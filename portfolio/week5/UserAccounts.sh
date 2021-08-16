#!/bin/bash

#The grep command looks through the /etc/passwd file for lines ending in "/bin/bash" and pipes the result into the awk function.
#The awk function takes the (resultant) /etc/passwd file and prints it to the CLI in a nicely formatted table.
grep '.*/bin/bash$' /etc/passwd | awk 'BEGIN {
    FS=":";
    print "__________________________________________________________________________________________";
    print "| \033[1;92mUsername\033[0m            | \033[2;92mUserID\033[0m | \033[2;92mGroupID\033[0m | \033[2;92mHome\033[0m                      | \033[2;92mShell\033[0m             |";
    print "------------------------------------------------------------------------------------------";
}
{
    printf("| \033[1;93m%-19s\033[0m | \033[94m%-6s\033[0m | \033[94m%-7s\033[0m | \033[94m%-25s\033[0m | \033[94m%-17s\033[0m |\n", $1, $3, $4, $6, $7);
}
END {
    print "|_____________________|________|_________|___________________________|___________________|";
}'
exit 0