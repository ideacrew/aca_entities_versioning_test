# frozen_string_literal: true

require 'rake'

RSpec.describe "release.rake" do
  Rake::DefaultLoader.new.load 'tasks/release.rake'

  describe 'custom:release' do
    before do
      # IMPORTANT: these lines stub the file system calls to prevent actual file system changes
      # Do not modify these lines
      allow(File).to receive(:delete).and_return(true)
      allow(File).to receive(:open).and_return(true)

      # IMPORTANT: this line stubs the system call to prevent shell commands from actually running
      # Do not modify this line
      allow(Kernel).to receive(:system).with(any_args).and_return(true)
    end

    # set up rake task options and command
    let(:version) { '1.0.0' }
    let(:type) { nil }
    let(:quiet) { 'true' }
    let(:rake_command) { "custom:release[#{version}, #{type},#{quiet}]" }

    let(:run_rake_task) do
      Rake::Task['custom:release'].reenable
      Rake.application.invoke_task rake_command
    end

    # set up expected commands
    let(:update_gem_ref_command) do
      'bundle update aca_entities'
    end
    let(:commit_bump_command) do
      "git commit -am 'Bump version to #{version}'"
    end
    let(:tag) { "v#{version}" }
    let(:tag_command) do
      "git tag -am #{tag} 'Release #{tag}'"
    end
    let(:push_command) do
      'git push'
    end
    let(:push_tag_command) do
      "git push #{tag}"
    end
    let(:full_update_and_commit_command) do
      "#{update_gem_ref_command} && #{commit_bump_command} && #{push_command} && #{tag_command} && #{push_tag_command}"
    end

    context 'errors' do
      context 'no version number provided' do
        let(:version) { nil }

        it 'raises an error if no version number is provided' do
          expect { run_rake_task }.to raise_error(RuntimeError, 'Please provide the desired version number for release.')
        end
      end

      context 'invalid version number provided' do
        let(:version) { 'v1.0.0' }

        it 'raises an error if version number is not correctly formatted' do
          expect { run_rake_task }.to raise_error(RuntimeError, 'Please provide a valid version string, e.g., 1.0.0')
        end
      end

      context 'invalid release type provided' do
        let(:type) { 'foo' }

        it 'raises an error if release type is not major, minor, or patch' do
          expect { run_rake_task }.to raise_error(RuntimeError, 'Please provide a valid release type: major, minor, or patch')
        end
      end
    end

    context 'VERSION file rewrite' do
      it 'deletes the VERSION file if it exists' do
        expect(File).to receive(:delete).with('VERSION')
        run_rake_task
      end

      it 'writes the new version number to the VERSION file' do
        expect(File).to receive(:open).with('VERSION', 'w')
        run_rake_task
      end
    end

    context 'update Gemfile, commit, tag and push command' do
      it 'executes the command' do
        expect(Kernel).to receive(:system).with(full_update_and_commit_command)
        run_rake_task
      end
    end

    context 'valid release type provided' do
      let(:type) { 'major' }

      before do
        allow(File).to receive(:read).with('VERSION').and_return(version)
        allow(Kernel).to receive(:system).with(full_update_and_commit_command).and_return(true)
      end

      it 'checks out the trunk branch' do
        expect(Kernel).to receive(:system).with('git checkout trunk')
        run_rake_task
      end

      it 'updates the Gemfile.lock to the new alpha version' do
        expect(Kernel).to receive(:system).with('bundle update aca_entities')
        run_rake_task
      end

      context 'major version of release is the same as major version on trunk' do
        context 'major type provided' do
          let(:type) { 'major' }
          let(:new_alpha_version) { '1.0.1.alpha' }

          context 'quiet mode is off' do
            let(:quiet) { 'false' }
            it 'updates the trunk version to the new alpha version' do
              # using the output to confirm the new alpha version is built correctly since the file system changes are stubbed
              expect { run_rake_task }.to output(/Updated trunk VERSION to #{new_alpha_version}/).to_stdout
            end
          end

          it 'commits the alpha version bump' do
            expect(Kernel).to receive(:system).with("git commit -am 'Bump version to #{new_alpha_version}'")
            run_rake_task
          end
        end

        context 'minor type provided' do
          let(:version) { '1.1.0' }
          let(:type) { 'minor' }
          let(:new_alpha_version) { '1.1.1.alpha' }

          context 'quiet mode is off' do
            let(:quiet) { 'false' }
            it 'updates the trunk version to the new alpha version' do
              # using the output to confirm the new alpha version is built correctly since the file system changes are stubbed
              expect { run_rake_task }.to output(/Updated trunk VERSION to #{new_alpha_version}/).to_stdout
            end
          end

          it 'commits the changes to the trunk branch' do
            expect(Kernel).to receive(:system).with("git commit -am 'Bump version to #{new_alpha_version}'")
            run_rake_task
          end
        end

        context 'patch type provided' do
          let(:version) { '1.1.1' }
          let(:type) { 'patch' }
          let(:new_alpha_version) { '1.1.2.alpha' }

          context 'quiet mode is off' do
            let(:quiet) { 'false' }
            it 'updates the trunk version to the new alpha version' do
              # using the output to confirm the new alpha version is built correctly since the file system changes are stubbed
              expect { run_rake_task }.to output(/Updated trunk VERSION to #{new_alpha_version}/).to_stdout
            end
          end

          it 'commits the changes to the trunk branch' do
            expect(Kernel).to receive(:system).with("git commit -am 'Bump version to #{new_alpha_version}'")
            run_rake_task
          end
        end
      end
    end
  end

  describe 'major:release' do
    let(:run_rake_task) do
      Rake::Task['major:release'].reenable
      Rake.application.invoke_task 'major:release'
    end

    before do
      allow(File).to receive(:read).with('VERSION').and_return('1.0.0')
      allow(Rake::Task['custom:release']).to receive(:invoke).and_return(true)
      run_rake_task
    end

    it 'invokes the custom:release task with the new major version number and major release type' do
      expect(Rake::Task['custom:release']).to have_received(:invoke).with('2.0.0', 'major', 'true')
    end
  end

  describe 'minor:release' do
    let(:run_rake_task) do
      Rake::Task['minor:release'].reenable
      Rake.application.invoke_task 'minor:release'
    end

    before do
      allow(File).to receive(:read).with('VERSION').and_return('1.0.0')
      allow(Rake::Task['custom:release']).to receive(:invoke).and_return(true)
      run_rake_task
    end

    it 'invokes the custom:release task with the new minor version number and minor release type' do
      expect(Rake::Task['custom:release']).to have_received(:invoke).with('1.1.0', 'minor', 'true')
    end
  end

  describe 'patch:release' do
    let(:run_rake_task) do
      Rake::Task['patch:release'].reenable
      Rake.application.invoke_task 'patch:release'
    end

    before do
      allow(File).to receive(:read).with('VERSION').and_return('1.0.0')
      allow(Rake::Task['custom:release']).to receive(:invoke).and_return(true)
      run_rake_task
    end

    it 'invokes the custom:release task with the new patch version number and patch release type' do
      expect(Rake::Task['custom:release']).to have_received(:invoke).with('1.0.1', 'patch', 'true')
    end
  end
end