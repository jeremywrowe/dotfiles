function lsd -d 'List only directories (in the current dir)'
    ls -d */ | sed -Ee 's,/+$,,'
end