# frozen_string_literal: true

desc 'Create a new release using a custom version string.'
namespace :custom do
  task :release, [:version, :type, :quiet] do |_t, args|

    # IMPORTANT: all shell commands must be executed using this method
    # Kernel.system is stubbed in the specs to prevent actual shell commands from running
    def execute_command(command, message)
      raise "Command failed: #{command}" unless Kernel.system(command)
      puts message unless @quiet_mode
    end

    def current_branch_is_trunk?
      branch_name = `git rev-parse --abbrev-ref HEAD`.strip
      branch_name == 'trunk'
    end

    def valid_version?(version)
      # check if version matches format 0.0.0
      version.match?(/^\d+\.\d+\.\d+$/)
    end

    def valid_type?(type)
      # type is optional, but if provided, it must be one of: major, minor, or patch
      type.nil? || ['major', 'minor', 'patch'].include?(type)
    end

    # validate rake context and input
    if current_branch_is_trunk?
      message = "You must NOT be on the trunk branch to create a new release."\
                " Example: to release v1.1.0, create a branch named v1.1.0 and run this rake there."
      raise message
    end
    raise "Please provide the desired version number for release." if args[:version].nil?
    raise "Please provide a valid version string, e.g., 1.0.0" unless valid_version?(args[:version])
    raise "If release type is provided, must be one of: major, minor, or patch." unless valid_type?(args[:type])

    # suppress output if quiet flag is provided
    # used primarily for testing purposes
    @quiet_mode = args[:quiet] == 'true'

    # get the version number
    version = args[:version]
    # create the tag string
    tag = "v#{version}"

    # remove VERSION file
    File.delete('VERSION') if File.exist?('VERSION')
    # make new VERSION file
    File.open('VERSION', 'w') { |f| f.write(version) }
    puts "Updated VERSION file to #{version}" unless @quiet_mode

    # check if the remote branch exists and create it if it doesn't
    branch_name = `git rev-parse --abbrev-ref HEAD`.strip
    remote_result = `git ls-remote --exit-code origin #{branch_name}`
    execute_command("git push -u origin #{branch_name}", "Created remote branch #{branch_name}.") unless remote_result.include?('refs/heads')

    # build command to update Gemfile, commit, tag and push
    command = ""
    # update version in Gemfile.lock
    command += 'bundle update aca_entities && '
    # commit changes
    command += "git commit -am 'Bump version to #{version}' && "
    # push the commit
    command += 'git push && '
    # tag the commit
    command += "git tag -am #{tag} 'Release #{tag}' && "
    # push the tag
    command += "git push #{tag}"
    # execute the command
    execute_command(command, "Updated Gemfile.lock to #{version} and committed changes with tag #{tag}")

    if args[:type].nil?
      unless @quiet_mode
        puts "Cannot update trunk version automatically without specifying the type of release. You MUST updated trunk version manually."
      end
    else
      # checkout trunk
      execute_command('git checkout trunk', "Checked out trunk branch.")

      # get the current version
      trunk_version = File.read('VERSION').strip

      trunk_major_number = trunk_version.split('.').first.to_i
      new_version_major_number = version.split('.').first.to_i
      # only update the trunk version if the major version is the same
      if trunk_major_number == new_version_major_number
        case args[:type]
        when 'major'
          new_alpha_version = "#{new_version_major_number}.0.1.alpha"
        when 'minor'
          new_minor_number = version.split('.')[1].to_i
          new_alpha_version = "#{trunk_major_number}.#{new_minor_number}.1.alpha"
        when 'patch'
          trunk_minor_number = trunk_version.split('.')[1].to_i
          new_patch_number = version.split('.')[2].to_i + 1
          new_alpha_version = "#{trunk_major_number}.#{trunk_minor_number}.#{new_patch_number}.alpha"
        end

        File.delete('VERSION') if File.exist?('VERSION')
        File.open('VERSION', 'w') { |f| f.write(new_alpha_version) }
        puts "Updated trunk VERSION to #{new_alpha_version}" unless @quiet_mode

        execute_command('bundle update aca_entities', "Updated Gemfile.lock to #{new_alpha_version}")
        execute_command("git commit -am 'Bump version to #{new_alpha_version}'", "Pushed alpha version bump to trunk.")
      end
    end
  end
end

# TODO: reconsider logic and scenario (e.g., do we run these from trunk or new branch? what are the assumptions about the new branch?, etc.)
# desc 'Create a new major release.'
# namespace :major do
#   task :release do
#     version = File.read("VERSION").strip
#     # create the new major version string
#     new_major_number = version.split('.').first.to_i + 1
#     new_major_version = "#{new_major_number}.0.0"
#     Rake::Task['custom:release'].invoke(new_major_version, 'major', 'false')
#   end
# end

# desc 'Create a new minor release.'
# namespace :minor do
#   task :release do
#     version = File.read("VERSION").strip
#     # create the new minor version string
#     major, minor = version.split('.')
#     major_number = major.to_i
#     new_minor_number = minor.to_i + 1
#     new_minor_version = "#{major_number}.#{new_minor_number}.0"
#     Rake::Task['custom:release'].invoke(new_minor_version, 'minor', 'false')
#   end
# end

# desc 'Create a new patch release.'
# namespace :patch do
#   task :release do
#     version = File.read("VERSION").strip
#     # create the new patch version string
#     major, minor, patch = version.split('.')
#     major_number = major.to_i
#     minor_number = minor.to_i
#     new_patch_number = patch.to_i + 1
#     new_patch_version = "#{major_number}.#{minor_number}.#{new_patch_number}"
#     Rake::Task['custom:release'].invoke(new_patch_version, 'patch', 'false')
#   end
# end