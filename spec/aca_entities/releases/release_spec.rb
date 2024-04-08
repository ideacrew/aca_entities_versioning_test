# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Releases::Release do

  subject { AcaEntities::Releases::Release.new(args) }

  let(:version) { '1.0.0' }
  let(:tag) { "v#{version}" }
  let(:type) { nil }
  let(:quiet) { 'true' }
  let(:args) { { version: version, type: type, quiet: quiet } }
  let(:update_and_commit_command) do
    'bundle update aca_entities && '\
      "git commit -am 'Bump version to #{version}' && "\
      'git push && '\
      "git tag -a #{tag} -m 'Release #{tag}' && "\
      "git push origin #{tag}"
  end

  before do
    # IMPORTANT: these lines stub the file system calls to prevent actual file system changes
    # Do not modify these lines
    allow(File).to receive(:delete).and_return(true)
    allow(File).to receive(:open).and_return(true)

    # IMPORTANT: this line stubs the system call to prevent shell commands from actually running
    # Do not modify this line
    allow(Kernel).to receive(:system).with(any_args).and_return(true)

    allow(subject).to receive(:current_branch_is_trunk?).and_return(false)
  end

  context "#custom_release" do
    context 'errors' do
      context 'running the class on trunk' do
        before do
          allow(subject).to receive(:current_branch_is_trunk?).and_return(true)
        end

        it 'raises an error if the class is run on the trunk branch' do
          message = "You must NOT be on the trunk branch to create a new release."\
                    " Example: to release v1.1.0, create a branch named v1.1.0 and run this rake there."
          expect { subject.custom_release }.to raise_error(RuntimeError, message)
        end
      end

      context 'no version number provided' do
        let(:version) { nil }

        it 'raises an error if no version number is provided' do
          expect { subject.custom_release }.to raise_error(RuntimeError, 'Please provide the desired version number for release.')
        end
      end

      context 'invalid version number provided' do
        let(:version) { 'v1.0.0' }

        it 'raises an error if version number is not correctly formatted' do
          expect { subject.custom_release }.to raise_error(RuntimeError, 'Please provide a valid version string, e.g., 1.0.0')
        end
      end

      context 'invalid release type provided' do
        let(:type) { 'foo' }

        it 'raises an error if release type is not major, minor, or patch' do
          expect { subject.custom_release }.to raise_error(RuntimeError, 'If release type is provided, must be one of: major, minor, or patch.')
        end
      end
    end

    context 'VERSION file rewrite' do
      it 'deletes the VERSION file if it exists' do
        expect(File).to receive(:delete).with('VERSION')
        subject.custom_release
      end

      it 'writes the new version number to the VERSION file' do
        expect(File).to receive(:open).with('VERSION', 'w')
        subject.custom_release
      end
    end

    context 'update Gemfile, commit, tag and push command' do
      it 'executes the command' do
        expect(Kernel).to receive(:system).with(update_and_commit_command)
        subject.custom_release
      end
    end

    context 'valid release type provided' do
      let(:type) { 'major' }

      before do
        allow(File).to receive(:read).with('VERSION').and_return(version)
        allow(Kernel).to receive(:system).with(update_and_commit_command).and_return(true)
      end

      it 'checks out the trunk branch' do
        expect(Kernel).to receive(:system).with('git checkout trunk')
        subject.custom_release
      end

      it 'updates the Gemfile.lock to the new alpha version' do
        expect(Kernel).to receive(:system).with('bundle update aca_entities')
        subject.custom_release
      end

      context 'major version of release is the same as major version on trunk' do
        context 'major type provided' do
          let(:type) { 'major' }
          let(:new_alpha_version) { '1.0.1.alpha' }

          context 'quiet mode is off' do
            let(:quiet) { 'false' }
            it 'updates the trunk version to the new alpha version' do
              # using the output to confirm the new alpha version is built correctly since the file system changes are stubbed
              expect { subject.custom_release }.to output(/Updated trunk VERSION to #{new_alpha_version}/).to_stdout
            end
          end

          it 'commits the alpha version bump' do
            expect(Kernel).to receive(:system).with("git commit -am 'Bump version to #{new_alpha_version}'")
            subject.custom_release
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
              expect { subject.custom_release }.to output(/Updated trunk VERSION to #{new_alpha_version}/).to_stdout
            end
          end

          it 'commits the changes to the trunk branch' do
            expect(Kernel).to receive(:system).with("git commit -am 'Bump version to #{new_alpha_version}'")
            subject.custom_release
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
              expect { subject.custom_release }.to output(/Updated trunk VERSION to #{new_alpha_version}/).to_stdout
            end
          end

          it 'commits the changes to the trunk branch' do
            expect(Kernel).to receive(:system).with("git commit -am 'Bump version to #{new_alpha_version}'")
            subject.custom_release
          end
        end
      end
    end
  end
end