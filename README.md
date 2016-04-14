# ExSshd

[![Build Status](https://travis-ci.org/tverlaan/ex_sshd.svg?branch=master)](https://travis-ci.org/tverlaan/ex_sshd)
[![Hex.pm Version](http://img.shields.io/hexpm/v/ex_sshd.svg?style=flat)](https://hex.pm/packages/ex_sshd)

Simple Elixir SSH worker that provides an Elixir shell over SSH into your application. This is an Elixir port of [erl_sshd](https://github.com/ivanos/erl_sshd) but runs an elixir shell instead of an erlang shell.

*Please note:* exit only works client side (`~.`) or making the process crash (`h`) (it won't crash the application and the SSH daemon will restart itself)

## Installation

Add it to your `mix.exs` file like either one of this:
```
defp deps do
  [{:ex_sshd, github: "tverlaan/ex_sshd"},
  {:ex_sshd, "~> 0.0.2"}]
end
```

Then ensure ex_sshd is started before your application:
```
def application do
  [applications: [:ex_sshd]]
end
```

## Configuration

You can use SSH keys and/or usernames and passwords for authentication. I would recommend using keys.

### Using keys

Either use the `make_keys` bash script or use `make_host_key` and put your own key in `priv/ex_sshd/authorized_keys`

### Using username/password combo

First run the `make_host_key` script and then add username and password combinations to the configuration as in the example below.

### Example

```
config :ex_sshd,
  app: :your_application_name,
  port: 10022,
  credentials: [{"username", "password"}]
```


## TODO

- To support `h` (IEx helper function) we need ansi support in the SSH channel, right now you could use the following configuration to make it work:

```
config :elixir,
  ansi_enabled: false
```

- Proper way to exit from the server side. Right now only `~.` from the client is supported to exit.
