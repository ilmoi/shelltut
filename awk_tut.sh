# the syntax is
# awk ' condition { action }'.

# we're printing etc/passwd contents, line by line, using colon as column separator and starting with 5th col, then 4th, 3rd, etc
# awk -F":" ' { print $5 $4 $3 $2 $1 } ' /etc/passwd

# now we're telling awk to only print rows 1 through 5
# awk -F":" ' NR==10,NR==20{ print $1 } ' /etc/passwd

# now we're going to format our output
# we use %- for left justified and we use % for right justified
# 20 and 3 are sizes of columns
# s = string, d = decimal
# \n simply means new line
# awk -F":" ' NR==10,NR==20{ printf "%-20s %3d\n", $1, $3 } ' /etc/passwd
# now our output looks a lot prettier!!!

# awk -F":" ' { printf "%-20s %20s %20s\n", $1, $2, $3 } ' database.txt

# now let's add header info
awk -F":" '
BEGIN {
print "====================================================================="
printf "%-20s %-3s %-3s %-15s %-15s\n", "User", "UID", "GID", "Home", "Shell"
print "====================================================================="}
NR==10,NR==20{
printf "%-20s %3d %3d %-15s %-15s\n", $1, $3, $4, $6, $7 } ' /etc/passwd
