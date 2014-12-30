#!/usr/bin/env ruby
#
# Returns a comma-seperated string with all the IPs of all configured 
# nameservers in /etc/resolv.conf
#
# I live in site/lib/facter/resolv_conf_nameservers.rb
# 

Facter.add(:resolv_conf_nameservers) do
    confine :kernel => [ :linux, :solaris, :darwin, :aix ]

    setcode do
      nameservers = []

      # Find all the nameserver values in /etc/resolv.conf
      File.open("/etc/resolv.conf", "r").each_line do |line|
        if line =~ /^nameserver\s*(\S*)/
          nameservers.push($1.gsub(/\s+/,''))
        end
      end

      nameservers.join(',')
    end
end
