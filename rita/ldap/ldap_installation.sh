# Install and Configure
sudo apt update
sudo apt-get install slapd ldap-utils

sudo DEBIAN_FRONTEND=readline dpkg-reconfigure slapd

# Search
ldapsearch -x -D cn=admin,dc=example,dc=com -H ldap:/// -b ou=People,dc=example,dc=com dn
ldapsearch -x -D cn=admin,dc=example,dc=com -H ldap:/// -W -b "dc=example,dc=com" "(objectClass=inetOrgPerson)"

# Delete
ldapdelete -x -D cn=admin,dc=example,dc=com -H ldap:/// -W "ou=People,dc=example,dc=com"
ldapdelete -x -D cn=admin,dc=example,dc=com -H ldap:/// -W "ou=Groups,dc=example,dc=com"

ldapdelete -x -D cn=admin,dc=example,dc=com -H ldap:/// -W "cn=groupA,ou=Groups,dc=example,dc=com"

# Add data
ldapadd -x -D cn=admin,dc=example,dc=com -W -f add_content.ldif