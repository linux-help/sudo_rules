sudo_rules Cookbook
===================
Reads through a special data bag of sudo rules to compile a list of sudoers.d rules to create/remove.

Requirements
------------
#### packages
- sudo

Attributes
----------

#### sudo_rules::default

Key              | Type   | Description                          | Default
---------------- | ------ | ------------------------------------ | ----------
`['sudo_rules']` | String | Name of data bag to use for entries. | sudo_rules

Usage
-----
#### sudo_rules::default

Include `sudo_rules` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[sudo_rules]"
  ]
}
```

And provide properly formatted data bag:

```json
{
    "id": "Data Bag unique name, default value for name below",
    "name": "Name of the sudoers.d file",
    "hosts": [
        "fqdn1",
        "fqdn2",
        ...
    ],
    "action": "create",
    "user": "someuser",
    "runas": "ALL",
    "commands": [
        "/usr/sbin/somecommand args",
        "/usr/sbin/anothercommand",
        ...
    ],
    "defaults": [
        "env_reset"
    ]
}
```

Key      | Type   | Description                                                                          | Default    | Required?
-------- | ------ | ------------------------------------------------------------------------------------ | ---------- | ---------
Id       | String | Name of Data Bag item, and sudoers.d/Id filename.                                    | None       | Yes
Name     | String | Instead of using Id, you can choose the name of the file for sudoers.d/Name instead. | Same as Id | No
Hosts    | Array  | List of hosts to apply this rule to by fqdn, can be wildcard matched.                | []         | Yes
Action   | String | `create` or `remove` Sets whether to create or remove the entry.                     | `create`   | No
User     | String | Username or %Groupname to use for the sudo rule.                                     | None       | Yes
Runas    | String | Allowed colon-separated list of users for sudoers runas.                             | `ALL`      | No
Commands | Array  | List of commands (and arguments) this rule adds for the user/group.                  | []         | Yes
Defaults | Array  | List of defaults this user has.                                                      | []         | No

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Eric Renfro <erenfro@linux-help.org>


