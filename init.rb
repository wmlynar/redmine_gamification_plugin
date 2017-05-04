# coding: utf-8

#Rails.configuration.to_prepare do
#  unless Issue.included_modules.include? IssuePatch
#    Issue.send(:include, IssuePatch)
#  end
#
#  unless WikiContent.included_modules.include? WikiPatch
#    WikiContent.send(:include, WikiPatch)
#  end
#end

Redmine::Plugin.register :redmine_gamification_plugin do
  name 'Gamification plugin'
  author 'Mauricio Camayo'
  description 'Gamification is the use of game mechanics, dynamics (e.g., competitive behaviour) and emotions (e.g., anticipation) in order to engage players employees in updating their issues on Redmine'
  version '0.0.4'
  url 'https://github.com/mauricio-camayo/redmine_gamification_plugin'
  author_url 'https://github.com/mauricio-camayo'

  permission :redmine_gamification_plugin, :gamification => :index, :public => true

  menu :top_menu, :gamification, {controller: 'gamification', action: 'index'}, :caption => :plugin_name, :if => Proc.new{User.current.allowed_to?({:controller => 'gamification', :action => 'index'}, nil, {:global => true})}
  menu :project_menu, :gamification, {controller: 'gamification', action: 'project'}, :caption => :plugin_name, :param => :project_id, :if => Proc.new{User.current.allowed_to?({:controller => 'gamification', :action => 'index'}, nil, {:global => true})}

  settings :default => {'empty' => true}, :partial => 'settings/gamification_settings'
end

require_dependency 'hooks/controller_issues_edit_after_save_hook.rb'
require_dependency 'hooks/controller_issues_edit_before_save_hook.rb'
require_dependency 'hooks/controller_issues_bulk_edit_before_save_hook.rb'
require_dependency 'hooks/controller_issues_new_after_save_hook.rb'
require_dependency 'hooks/controller_wiki_edit_after_save_hook.rb'
