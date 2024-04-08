# frozen_string_literal: true

require 'pry'

# Class used for automating release of a new version of the aca_entities gem.
# This class is used by tasks/release.rake.
module AcaEntities
  module Releases
    class Release
      attr_reader :version, :type, :quiet_mode

      def initialize(args)
        @version = args[:version]
        @type = args[:type]
        # suppress output if quiet flag is provided
        # used primarily for testing purposes
        @quiet_mode = args[:quiet] == 'true'
      end

      def custom_release
        # validate rake context and input
        validate_context_and_input

        tag = "v#{@version}"

        # replace old VERSION file and with new VERSION file
        rewrite_version_file(@version)
        puts "Updated VERSION file to #{@version}" unless @quiet_mode

        # check if the remote branch exists and create it if it doesn't
        check_remote_branch

        # execute command to:
        # 1. update version in Gemfile.lock
        # 2. commit changes
        # 3. push the commit
        # 4. tag the commit
        # 5. push the tag
        command = 'bundle update aca_entities && '\
                  "git commit -am 'Bump version to #{version}' && "\
                  'git push && '\
                  "git tag -a #{tag} -m 'Release #{tag}' && "\
                  "git push origin #{tag}"
        execute_command(command, "Updated Gemfile.lock to #{version} and committed changes with tag #{tag}")

        if @type.nil?
          unless @quiet_mode
            puts "Cannot update trunk version automatically without specifying the type of release. You MUST updated trunk version manually."
          end
        else
          # update trunk version and commit
          update_trunk_version
        end
      end

      private

      def validate_context_and_input
        if current_branch_is_trunk?
          message = "You must NOT be on the trunk branch to create a new release."\
                    " Example: to release v1.1.0, create a branch named v1.1.0 and run this rake there."
          raise message
        end
        raise "Please provide the desired version number for release." if @version.nil?
        raise "Please provide a valid version string, e.g., 1.0.0" unless valid_version?(@version)
        raise "If release type is provided, must be one of: major, minor, or patch." unless valid_type?(@type)
      end

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

      def rewrite_version_file(version)
        File.delete('VERSION') if File.exist?('VERSION')
        File.open('VERSION', 'w') { |f| f.write(version) }
      end

      def valid_version?(version)
        # check if version matches format 0.0.0
        version.match?(/^\d+\.\d+\.\d+$/)
      end

      def valid_type?(type)
        # type is optional, but if provided, it must be one of: major, minor, or patch
        type.nil? || ['major', 'minor', 'patch'].include?(type)
      end

      def check_remote_branch
        branch_name = `git rev-parse --abbrev-ref HEAD`.strip
        remote_result = `git ls-remote --exit-code origin #{branch_name}`
        execute_command("git push -u origin #{branch_name}", "Created remote branch #{branch_name}.") unless remote_result.include?('refs/heads')
      end

      def build_new_alpha_version(trunk_major_number, new_version_major_number, trunk_version)
        case @type
        when 'major'
          "#{new_version_major_number}.0.1.alpha"
        when 'minor'
          new_minor_number = @version.split('.')[1].to_i
          "#{trunk_major_number}.#{new_minor_number}.1.alpha"
        when 'patch'
          trunk_minor_number = trunk_version.split('.')[1].to_i
          new_patch_number = @version.split('.')[2].to_i + 1
          "#{trunk_major_number}.#{trunk_minor_number}.#{new_patch_number}.alpha"
        end
      end

      def update_trunk_version
        # checkout trunk
        execute_command('git checkout trunk', "Checked out trunk branch.")

        # get the current version
        trunk_version = File.read('VERSION').strip

        trunk_major_number = trunk_version.split('.').first.to_i
        new_version_major_number = @version.split('.').first.to_i

        # only update the trunk version if the major version is the same
        if trunk_major_number == new_version_major_number
          new_alpha_version = build_new_alpha_version(trunk_major_number, new_version_major_number, trunk_version)
          rewrite_version_file(new_alpha_version)
          puts "Updated trunk VERSION to #{new_alpha_version}" unless @quiet_mode

          execute_command('bundle update aca_entities', "Updated Gemfile.lock to #{new_alpha_version}")
          execute_command("git commit -am 'Bump version to #{new_alpha_version}'", "Pushed alpha version bump to trunk.")
        else
          puts "Major version of release does not match major version on trunk. Skipping trunk version update." unless @quiet_mode
        end
      end
    end
  end
end