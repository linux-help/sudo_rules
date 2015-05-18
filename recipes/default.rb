#
# Cookbook Name:: sudo_rules
# Recipe:: default
#
# Copyright 2015, Linux-Help.org
#
# All rights reserved - Do Not Redistribute
#

include_recipe "sudo"

node.override['authorization']['sudo']['include_sudoers_d'] = true
search_node = node['fqdn']

if node['sudo_rules'].key?('search_query') && node['sudo_rules']['search_query'] != ''
    search_query = node['sudo_rules']['search_query']
else
    search_query = "hosts:#{search_node}"
end

if Chef::Config[:solo] and nod chef_solo_search_installed?
    Chef::Log.warn("This recipe uses search. Chef Solo does not support search unless you install the chef-solo-search cookbook.")
else
    search(node['sudo_rules']['data_bag'], search_query).each do |rule|
        # Name
        if rule["name"].kind_of?(String)
            rule_name = rule["name"]
        else
            rule_name = rule["id"]
        end

        # Action Create/Remove
        if rule["action"].kind_of?(String)
            if rule["action"] == "create" or rule["action"] == "remove"
                rule_action = rule["action"]
            else
                rule_action = "create"
            end
        else
            rule_action = "create"
        end

        # Username or Group
        if rule['user'].kind_of?(String)
            rule_user = rule['user']
        else
            Chef::Log.warn("data_bag #{rule['id']} has no user entry and is required. Skipped.")
            next
        end

        # Pasword or NoPassword
        if rule['nopasswd'].kind_of?(TrueClass)
            rule_nopasswd = rule['nopasswd']
        else
            rule_nopasswd = false
        end

        # RunAS
        if rule['runas'].kind_of?(String)
            rule_runas = rule['runas']
        else
            rule_runas = 'ALL'
        end

        # Commands
        if rule['commands'].kind_of?(Array)
            rule_commands = rule['commands']
        elsif rule['rules'].kind_of?(String)
            rule_commands = [ rule['commands'] ]
        else
            Chef::Log.warn("data_bag #{rule['id']} has no commands is required. Skipped.")
            next
        end

        # Defaults
        if rule['defaults'].kind_of?(Array)
            rule_defaults = rule['defaults']
        elsif rule['defaults'].kind_of?(String)
            rule_defaults = [ rule['defaults'] ]
        else
            rule_defaults = []
        end

        sudo rule["id"] do
            name        rule_name
            user        rule_user
            runas       rule_runas
            nopasswd    rule_nopasswd
            commands    rule_commands
            defaults    rule_defaults
        end
    end
end

