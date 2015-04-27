
#
# https://github.com/CocoaPods/CocoaPods/blob/master/spec/spec_helper/temporary_repos.rb
#

module SpecHelper
  def self.tmp_repos_path
    TemporaryRepos.tmp_repos_path
  end

  module TemporaryRepos
    extend Pod::Executable
    executable :svn

    #
    # Copy test-repo to temp location and initialize local svn repository
    #
    def repo_make(name)
      path = repo_path(name)
      path.mkpath
      Dir.chdir(path) do
        `echo stuff`
        `touch dustywusyt`
      end
      path
    end

    #
    # @return [Pathname] The path for the repo with the given name.
    #
    def repo_path(name)
      tmp_repos_path + name
    end

    # Sets up a lightweight svn master repo in `tmp/cocoapods/repos/master` with the
    # contents of `spec/fixtures/spec-repos/test_repo`.
    #
    def set_up_test_repo
      puts "Set up tst repo!"
      # require 'fileutils'
      # test_repo_path.mkpath
      # origin = ROOT + 'spec/fixtures/spec-repos/test_repo/.'
      # destination = tmp_repos_path + 'master'
      # FileUtils.cp_r(origin, destination)
      # repo_make('master')
    end

    #--------------------------------------#

    def tmp_repos_path
      SpecHelper.temporary_directory + 'cocoapods/repos'
    end

    module_function :tmp_repos_path

    def self.extended(base)
      base.before do
        tmp_repos_path.mkpath
      end
    end

  end
end
