
#!/bin/bash
SAVEDIFS=$IFS
IFS=$(echo -en "\n\b")
#FILES=*

FILES=$(find . ! -name "*~" ! -name "*.sh" ! -name "*.swp" ! -name 'SHA1SUM' ! -name 'MD5SUM' -type f -exec basename {} \; | sort)

for hashFile in SHA1SUM MD5SUM
do
    echo "Processing $hashFile file."
    #Delete certain file(s).
    [[ -f "$hashFile" ]] && rm -f "$hashFile"
done

for file in $FILES
do
    #Ignoring certain file(s).
    if [ "$file" == "SHA1SUM" ] || [ "$file" == "MD5SUM" ] ; then
        echo "Ignoring $file file."
        continue;
    fi
    echo "Processing $file file."
    #Process each file. The $file store current file name.
    #md5sum $file | tee --append MD5SUM
    md5sum $file >> MD5SUM
    #sha1sum $file | tee --append SHA1SUM
    sha1sum $file >> SHA1SUM
done

IFS=$SAVEDIFS
