local PS1 = settings.get("login.user").. " " .. shell.dir() .. " # "
settings.set("PS1", PS1)