![shippable CI]
(https://img.shields.io/shippable/55f17bf61895ca4474146421.svg)

## README

### Setup Database

Reset database and load seed data:

```
$ rake db:drop db:create db:migrate db:seed
```

### Vagrant

You will need to install the Vagrant and Virtualbox first. After that you can setup develop enviroment by one command.

**Refrences:**

https://www.vagrantup.com/

https://gorails.com/guides/using-vagrant-for-rails-development

**Install plugin for Vagrant first:**

```
vagrant plugin install vagrant-librarian-chef-nochef
```

**How to start the Vagrant in project directory:**

```
vagrant up
```

**Start rails server:**
```
vagrant ssh -c ./serve
```

**Login VM:**
```
vagrant ssh
```

By default, Vagrant will share your project directory (the directory with the Vagrantfile) to `/vagrant`.

Notice: If bundle command fail when bootstrap, you can run it manually after login.

### Sublime Setting

Below the sublime setting should be used for coding convention.

```
{
  "dictionary": "Packages/Language - English/en_GB.dic",
  "ensure_newline_at_eof_on_save": true,
  "tab_size": 2,
  "translate_tabs_to_spaces": true,
  "trim_trailing_white_space_on_save": true,
}
```
