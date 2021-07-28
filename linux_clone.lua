local args = {...}
if #args == 1 then
    local command = args[1]
    if (command == "install") then
        print(fs.delete("/bin"))
        print(fs.delete("/etc"))
        print(fs.delete("/home"))
        print(fs.delete("/root"))
        print(fs.delete("/startup"))
        print(fs.delete("/usr"))
        print(fs.delete("/var"))
        print(fs.makeDir("/bin"))
        print(fs.makeDir("/etc"))
        print(fs.makeDir("/home"))
        print(fs.makeDir("/home/testuser"))
        print(fs.makeDir("/root"))
        print(fs.makeDir("/startup"))
        print(fs.makeDir("/usr"))
        print(fs.makeDir("/usr/bin"))
        print(fs.makeDir("/usr/sbin"))
        print(fs.makeDir("/var"))
        print(fs.makeDir("/var/log"))
        term.write("Do you wish to disable the testuser(y/n): ")
        local testuser = read()
        local rootPassNotEqual = true
        local newRootPass = ""
        while rootPassNotEqual do
            term.write("New Root Password: ")
            newRootPass = read(" ")
            term.write("Confirm Root Password: ")
            confirmRootPass = read(" ")
            if newRootPass == confirmRootPass then
                rootPassNotEqual = false
            else
                print("Error: Passwords Do Not Match")
            end
        end
        local usersDataJSON = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/etc/passwd")
        local usersData = textutils.unserializeJSON(usersDataJSON.readAll())
        usersDataJSON.close()
        if (testuser == "y" or testuser == "Y") then
            usersData[2].enabled = false
        elseif (testuser == "n" or testuser == "N") then
            local testPassNotEqual = true
            local newTestPass = ""
            local confirmTestPass = ""
            while testPassNotEqual do
                term.write("New testuser Password: ")
                newTestPass = read(" ")
                term.write("Confirm testuser Password: ")
                confirmTestPass = read(" ")
                if newTestPass == confirmTestPass then
                    testPassNotEqual = false
                else
                    print("Error: Passwords Do Not Match")
                end
            end
            if (testPassNotEqual == false) then
                usersData[2].password = newTestPass
            end
        end
        if (rootPassNotEqual == false) then
            usersData[1].password = newRootPass
        end
        local hostnameNotSet = true
        while hostnameNotSet do
            term.write("New Hostname: ")
            local hostname = read()
            if (hostname == "") then
                print("Error: Hostname must not be empty")
            else
                local file = fs.open("/etc/hostname", "w")
                file.write(hostname)
                file.close()
                hostnameNotSet = false
            end
        end
        local usersFile = fs.open("/etc/passwd", "w")
        usersFile.write(textutils.serializeJSON(usersData))
        usersFile.close()
        -- /bin
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/bin/bash.lua")
        local file = fs.open("/bin/bash.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/bin/edit.lua")
        local file = fs.open("/bin/edit.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/bin/hostname.lua")
        local file = fs.open("/bin/hostname.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/bin/logout.lua")
        local file = fs.open("/bin/logout.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/bin/pwd.lua")
        local file = fs.open("/bin/pwd.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/bin/version.lua")
        local file = fs.open("/bin/version.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        -- /usr/bin
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/usr/bin/login.lua")
        local file = fs.open("/usr/bin/login.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/usr/bin/passwd.lua")
        local file = fs.open("/usr/bin/passwd.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/usr/bin/su.lua")
        local file = fs.open("/usr/bin/su.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/usr/bin/sudo.lua")
        local file = fs.open("/usr/bin/sudo.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/usr/bin/which.lua")
        local file = fs.open("/usr/bin/which.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/usr/bin/whoami.lua")
        local file = fs.open("/usr/bin/whoami.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        -- /usr/sbin
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/usr/sbin/adduser.lua")
        local file = fs.open("/usr/sbin/adduser.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/usr/sbin/enuser.lua")
        local file = fs.open("/usr/sbin/enuser.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/usr/sbin/useradd.lua")
        local file = fs.open("/usr/sbin/useradd.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        -- /startup
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/startup/00_path.lua")
        local file = fs.open("/startup/00_path.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/startup/99_login.lua")
        local file = fs.open("/startup/99_login.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        fs.move("/linux_clone.lua", "/bin/linux_clone.lua")
        term.write("OS Reboot Required(y/n): ")
        local doReboot = read()
        if (doReboot == "y" or doReboot == "Y") then
            os.reboot()
        end
    elseif (command == "update") then
        -- /bin
        print(fs.delete("/bin/bash.lua"))
        print(fs.delete("/bin/hostname.lua"))
        print(fs.delete("/bin/logout.lua"))
        print(fs.delete("/bin/pwd.lua"))
        print(fs.delete("/bin/version.lua"))
        -- /startup
        print(fs.delete("/startup/00_path.lua"))
        print(fs.delete("/startup/99_login.lua"))
        -- /usr/bin
        print(fs.delete("/usr/bin/login.lua"))
        print(fs.delete("/usr/bin/passwd.lua"))
        print(fs.delete("/usr/bin/su.lua"))
        print(fs.delete("/usr/bin/sudo.lua"))
        print(fs.delete("/usr/bin/which.lua"))
        print(fs.delete("/usr/bin/whoami.lua"))
        -- /usr/sbin
        print(fs.delete("/usr/sbin/adduser.lua"))
        print(fs.delete("/usr/sbin/useradd.lua"))
        -- /bin
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/bin/bash.lua")
        local file = fs.open("/bin/bash.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/bin/hostname.lua")
        local file = fs.open("/bin/hostname.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/bin/logout.lua")
        local file = fs.open("/bin/logout.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/bin/pwd.lua")
        local file = fs.open("/bin/pwd.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/bin/version.lua")
        local file = fs.open("/bin/version.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        -- /usr/bin
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/usr/bin/login.lua")
        local file = fs.open("/usr/bin/login.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/usr/bin/passwd.lua")
        local file = fs.open("/usr/bin/passwd.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/usr/bin/su.lua")
        local file = fs.open("/usr/bin/su.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/usr/bin/sudo.lua")
        local file = fs.open("/usr/bin/sudo.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/usr/bin/which.lua")
        local file = fs.open("/usr/bin/which.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/usr/bin/whoami.lua")
        local file = fs.open("/usr/bin/whoami.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        -- /usr/sbin
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/usr/sbin/adduser.lua")
        local file = fs.open("/usr/sbin/adduser.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/usr/sbin/useradd.lua")
        local file = fs.open("/usr/sbin/useradd.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        -- /startup
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/startup/00_path.lua")
        local file = fs.open("/startup/00_path.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/data/startup/99_login.lua")
        local file = fs.open("/startup/99_login.lua", "w")
        file.write(request.readAll())
        file.close()
        request.close()
        fs.move("/linux_clone.lua", "/bin/linux_clone.lua")
        term.write("OS Reboot Required(y/n): ")
        local doReboot = read()
        if (doReboot == "y" or doReboot == "Y") then
            os.reboot()
        end
    elseif (command == "remove") then
        -- /bin
        print(fs.delete("/bin/bash.lua"))
        print(fs.delete("/bin/hostname.lua"))
        print(fs.delete("/bin/logout.lua"))
        print(fs.delete("/bin/pwd.lua"))
        print(fs.delete("/bin/version.lua"))
        print(fs.delete("/bin/linux_clone.lua"))
        -- /etc
        print(fs.delete("/etc/hostname"))
        print(fs.delete("/etc/passwd"))
        -- /startup
        print(fs.delete("/startup/00_path.lua"))
        print(fs.delete("/startup/99_login.lua"))
        -- /usr/bin
        print(fs.delete("/usr/bin/login.lua"))
        print(fs.delete("/usr/bin/passwd.lua"))
        print(fs.delete("/usr/bin/su.lua"))
        print(fs.delete("/usr/bin/sudo.lua"))
        print(fs.delete("/usr/bin/which.lua"))
        print(fs.delete("/usr/bin/whoami.lua"))
        -- /usr/sbin
        print(fs.delete("/usr/sbin/adduser.lua"))
        print(fs.delete("/usr/sbin/useradd.lua"))
    elseif (command == "upgrade") then
        local curDir = shell.dir()
        local request = http.get("https://raw.githubusercontent.com/jfkinslow/CC-Linux-Clone/master/linux_clone.lua")
        local file = nil
        if (curDir == "") then
            if fs.exists("/linux_clone.lua") then
                file = fs.open("/linux_clone.lua", "w")
            else
                file = fs.open("/bin/linunx_clone.lua", "w")
            end
        else
            file = fs.open("/bin/linux_clone.lua", "w")
        end
        
        local data = request.readAll()
        textutils.slowPrint(data)
        file.write(data)
        file.close()
        request.close()
        local installer = ""
        if (curDir == "") then
            if fs.exists("/linux_clone.lua") then
                installer = "/linux_clone.lua"
            else
                installer = "/bin/linux_clone.lua"
            end
        else
            installer = "/bin/linux_clone.lua"
        end
        shell.run(installer, "update")
    else
        print("Usage   : linux_clone install|update|remove")
        print("install : Installs a fresh copy of CC-Linux-Clone")
        print("update  : updates the already installed copy of CC-Linux-Clone")
        print("upgrade : Replaces this file with a newer copy and updates CC-Linux-Clone")
        print("remove  : Removes all files required for CC-Linux-Clone (saves user files)")
    end
end