require 'redmine'
require 'dispatcher'
require 'time_enties_patch'

unless Redmine::Plugin.registered_plugins.keys.include?(:redmine_linked_time_entries)
	Redmine::Plugin.register :redmine_linked_time_entries do
	  name 'Linked time entries plugin'
	  author 'Nikita Vasiliev'
	  author_url 'mailto:sharpyfox@gmail.com'
	  description 'plugin for Redmine which add links to issues at time entries report'
	  version '0.0.1'
    requires_redmine :version_or_higher => '1.4.0'
	end
end

Dispatcher.to_prepare :redmine_linked_time_entries do
  require_dependency 'timelog_helper'

  unless TimelogHelper.included_modules.include? TimeEntries::Patches::LinkedTimeEntriesPatch
    TimelogHelper.send(:include, TimeEntries::Patches::LinkedTimeEntriesPatch)
  end
end
