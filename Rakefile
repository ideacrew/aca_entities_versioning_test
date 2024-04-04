# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

# include all external rake tasks in the tasks directory
Dir.glob('tasks/*.rake').each { |r| import r }

# rubocop:disable Lint/SuppressedException
begin
  require "fileutils"
  require "yard"
  require "yard/rake/yardoc_task"

  YARD::Rake::YardocTask.new do |t|
    # rubocop:disable Style/IfUnlessModifier
    if ENV["YARD_CACHE"] == "true"
      t.options = t.options + ["--use-cache"]
    end
    # rubocop:enable Style/IfUnlessModifier
  end

  desc "Generate Yard and Hugo Site"
  task :docsite => :yard do
    FileUtils.cp_r "./doc", "./hugo/static/", preserve: false
    build_command = "hugo"
    if ENV["NVM_VERSION"]
      nvm_v = ENV["NVM_VERSION"]
      build_command = "nvm use #{nvm_v} && " + build_command
    end
    hugo_result = system("bash -lc '#{build_command}'", chdir: "./hugo")
    exit(-1) unless hugo_result
  end

  desc "Serve the hugo site locally"
  task :docserver => :yard do
    FileUtils.cp_r "./doc", "./hugo/static/", preserve: false
    build_command = "hugo serve"
    system("bash -lc '#{build_command}'", chdir: "./hugo")
  end

  # desc 'Create a new major release.'
  # namespace :major do
  #   task :release do
  #     version = File.read("VERSION").strip
  #     # create the new major version string
  #     new_major_number = version.split('.').first.to_i + 1
  #     new_major_version = "#{new_major_number}.0.0"
  #     Rake::Task['custom:release'].invoke(new_major_version, 'major')
  #   end
  # end

  # desc 'Create a new minor release.'
  # namespace :minor do
  #   task :release do
  #     version = File.read("VERSION").strip
  #     # create the new minor version string
  #     major_number = version.split('.').first.to_i
  #     new_minor_number = version.split('.')[1].to_i + 1
  #     new_minor_version = "#{major_number}.#{new_minor_number}.0"
  #     Rake::Task['custom:release'].invoke(new_minor_version, 'minor')
  #   end
  # end

  # desc 'Create a new patch release.'
  # namespace :patch do
  #   task :release do
  #     version = File.read("VERSION").strip
  #     # create the new patch version string
  #     major_number = version.split('.').first.to_i
  #     minor_number = version.split('.')[1].to_i
  #     new_patch_number = version.split('.')[2].to_i + 1
  #     new_patch_version = "#{major_number}.#{minor_number}.#{new_patch_number}"
  #     Rake::Task['custom:release'].invoke(new_patch_version, 'patch')
  #   end
  # end

  # desc 'Create a new release using a custom version string.'
  # namespace :custom do
  #   task :release, [:version, :type] do |_t, args|
  #     raise "Please provide the desired version number for release." if args[:version].nil?
  #     # TODO: implement method to validate version number format
  #     # raise "Please provide a valid version string, e.g., v1.0.0" unless valid_version?(args[:version])
  #     version = args[:version]

  #     # create the tag string
  #     tag = "v#{version}"

  #     # remove VERSION file
  #     File.delete('VERSION') if File.exist?('VERSION')
  #     # make new VERSION file
  #     File.open('VERSION', 'w') { |f| f.write(version) }
  #     puts "Updated VERSION file to #{version}"

  #     # build the command string
  #     command = ""
  #     # update version in Gemfile.lock
  #     command += 'bundle update aca_entities &&'
  #     # commit changes
  #     command += "git commit -am 'Bump version to #{version}' &&"
  #     # tag the commit
  #     command += "git tag -a #{tag} &&"
  #     # push the commit
  #     command += 'git push &&'
  #     # push the tag
  #     command += "git push #{tag}"

  #     # execute the command
  #     # sh command
  #     puts "Updated Gemfile.lock to #{version} and committed changes with tag #{tag}"

  #     if args[:type].nil?
  #       puts "Cannot update trunk version automatically without specifying the type of release. You MUST updated trunk version manually."
  #     else
  #       # checkout trunk
  #       # sh 'git checkout trunk'
  #       puts "Checked out trunk branch."

  #       # get the current version
  #       trunk_version = File.read('VERSION').strip

  #       trunk_major_number = trunk_version.split('.').first.to_i
  #       new_version_major_number = version.split('.').first.to_i
  #       # only update the trunk version if the major version is the same
  #       if trunk_major_number == new_version_major_number
  #         case args[:type]
  #         when 'major'
  #           new_alpha_version = "#{new_version_major_number}.0.1.alpha"
  #         when 'minor'
  #           new_minor_number = version.split('.')[1].to_i
  #           new_alpha_version = "#{trunk_major_number}.#{new_minor_number}.1.alpha"
  #         when 'patch'
  #           trunk_minor_number = trunk_version.split('.')[1].to_i
  #           new_patch_number = version.split('.')[2].to_i + 1
  #           new_alpha_version = "#{trunk_major_number}.#{trunk_minor_number}.#{new_patch_number}.alpha"
  #         end

  #         File.delete('VERSION') if File.exist?('VERSION')
  #         File.open('VERSION', 'w') { |f| f.write(new_alpha_version) }
  #         puts "Updated trunk VERSION to #{new_alpha_version}"
  #         # sh 'bundle update aca_entities'
  #         puts "Updated Gemfile.lock to #{new_alpha_version}"
  #         # sh 'git commit -am "Bump version to #{new_alpha_version}"'
  #         puts "Pushed alpha version bump to trunk."
  #       end
  #     end
  #   end
  # end
rescue LoadError
end
# rubocop:enable Lint/SuppressedException