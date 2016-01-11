#!/bin/sh

if [[ "$#" -eq 0 ]] ; then
    echo "No argument(s) given."
    exit 1
fi

# echo "Number of Argument(s):  $#"
# echo "Argument(s): $*"
# echo "Argument(s): $@"

# re='^[0-9]+$'
# if ! [[ "$1" =~ $re ]] ; then
   # echo "Invalid numeric argument." >&2; exit 1
# fi

# if [[ -z $1 ]] ; then
    # echo "No argument given."
    # exit 1
# else
    # echo "Converting to Visual Studio Platform Toolset." $1
# fi

# http://mariusbancila.ro/blog/2015/08/12/version-history-of-vc-mfc-and-atl/

re='1[0-2,4]'
if [[ "$1" -ge 10 && "$1" -ne 13 && "$1" -le 14 && "$1" = $re ]]; then
    echo "Visual Studio Platform Toolset $1."
else
    echo "Invalid Visual Studio Platform Toolset version."
    echo "Valid options: 10 (2010), 11 (2012), 12 (2013), 14 (2015)"
    exit 1
fi

echo "Existing values..."
find \( -name '*.sln' -o -name '*.vcxproj' \) -exec sed -n '/# Visual Studio */p' {} \;
find \( -name '*.sln' -o -name '*.vcxproj' \) -exec sed -n '/^VisualStudioVersion \=/p' {} \;
find \( -name '*.sln' -o -name '*.vcxproj' \) -exec sed -n '/v[1][0-2,4][0]/p' {} \;
find \( -name '*.sln' -o -name '*.vcxproj' \) -exec sed -n '/ToolsVersion\="[1][0-2,4].[0]"/p' {} \;
find \( -name '*.sln' -o -name '*.vcxproj' \) -exec sed -n '/Format Version [[:digit:]]\+\.[[:digit:]]*/p' {} \; 
echo "Converting to new values..."

# Visual Studio 2015
if [[ "$1" -eq 14 ]]; then
    find \( -name '*.sln' -o -name '*.vcxproj' \) -exec sed -i 's/# Visual Studio .*/# Visual Studio 14/g' {} \;
    find \( -name '*.sln' -o -name '*.vcxproj' \) -exec sed -i 's/^VisualStudioVersion \=.*/VisualStudioVersion \= 14.0.24720.0/g' {} \;
    find \( -name '*.sln' -o -name '*.vcxproj' \) -exec sed -i 's/v[1][0-2,4][0]/v140/g' {} \;
    find \( -name '*.sln' -o -name '*.vcxproj' \) -exec sed -i 's/ToolsVersion\="[1][0-2,4].[0]"/ToolsVersion\=\"14.0\"/g' {} \;
    find \( -name '*.sln' -o -name '*.vcxproj' \) -exec sed -i 's/Format Version [[:digit:]]\+\.[[:digit:]]*/Format Version 12.00/g' {} \;
fi

# Visual Studio 2013
if [[ "$1" -eq 12 ]]; then
    find \( -name '*.sln' -o -name '*.vcxproj' \) -exec sed -i 's/# Visual Studio .*/# Visual Studio 2013/g' {} \;
    find \( -name '*.sln' -o -name '*.vcxproj' \) -exec sed -i 's/^VisualStudioVersion \=.*/VisualStudioVersion \= 12.0.40629.0/g' {} \;
    find \( -name '*.sln' -o -name '*.vcxproj' \) -exec sed -i 's/v[1][0-2,4][0]/v120/g' {} \;
    find \( -name '*.sln' -o -name '*.vcxproj' \) -exec sed -i 's/Format Version [[:digit:]]\+\.[[:digit:]]*/Format Version 12.00/g' {} \;
fi

# Visual Studio 2012
if [[ "$1" -eq 11 ]]; then
    find \( -name '*.sln' -o -name '*.vcxproj' \) -exec sed -i 's/# Visual Studio .*/# Visual Studio 2012/g' {} \;
    find \( -name '*.sln' -o -name '*.vcxproj' \) -exec sed -i 's/^VisualStudioVersion \=.*/VisualStudioVersion \= 11.0.61219.0/g' {} \;
    find \( -name '*.sln' -o -name '*.vcxproj' \) -exec sed -i 's/v[1][0-2,4][0]/v110/g' {} \;
    find \( -name '*.sln' -o -name '*.vcxproj' \) -exec sed -i 's/ToolsVersion\="[1][0-2,4].[0]"/ToolsVersion\=\"11.0\"/g' {} \;
    find \( -name '*.sln' -o -name '*.vcxproj' \) -exec sed -i 's/Format Version [[:digit:]]\+\.[[:digit:]]*/Format Version 12.00/g' {} \;
fi

# Visual Studio 2010
if [[ "$1" -eq 10 ]]; then
    find \( -name '*.sln' -o -name '*.vcxproj' \) -exec sed -i 's/# Visual Studio .*/# Visual Studio 2010/g' {} \;
    find \( -name '*.sln' -o -name '*.vcxproj' \) -exec sed -i 's/^VisualStudioVersion \=.*/VisualStudioVersion \= 10.0.40219.1/g' {} \;
    find \( -name '*.sln' -o -name '*.vcxproj' \) -exec sed -i 's/v[1][0-2,4][0]/v100/g' {} \;
    find \( -name '*.sln' -o -name '*.vcxproj' \) -exec sed -i 's/ToolsVersion\="[1][0-2,4].[0]"/ToolsVersion\=\"4.0\"/g' {} \;
    find \( -name '*.sln' -o -name '*.vcxproj' \) -exec sed -i 's/Format Version [[:digit:]]\+\.[[:digit:]]*/Format Version 11.00/g' {} \;
fi

echo "After conversion..."
find \( -name '*.sln' -o -name '*.vcxproj' \) -exec sed -n '/# Visual Studio */p' {} \;
find \( -name '*.sln' -o -name '*.vcxproj' \) -exec sed -n '/^VisualStudioVersion \=/p' {} \;
find \( -name '*.sln' -o -name '*.vcxproj' \) -exec sed -n '/v[1][0-2,4][0]/p' {} \;
find \( -name '*.sln' -o -name '*.vcxproj' \) -exec sed -n '/ToolsVersion\="[1][0-2,4].[0]"/p' {} \;
find \( -name '*.sln' -o -name '*.vcxproj' \) -exec sed -n '/Format Version [[:digit:]]\+\.[[:digit:]]*/p' {} \; 

exit 0