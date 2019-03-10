#!/usr/bin/env bash


# select all from tableName: 4 parameters
# select row from tableName primary value: 6 paramters

function select_all_from_table() {
    if [[ $1 ]]; then
        TABLE_META="$1_meta"
        TABLE_NAME="$1"
        # Metadata Printing
        META_DATA=$(<TABLE_META)
        set -- "$META_DATA"
        IFS="|"; declare -a Array=($*)
        printf "#> TABLE: ${1}:\n"
        for (( i=0; i<${#Array[@]}-2; i++ ))
        do
            if [[ "${Array[i]}" != "int" ]] || [[ "${Array[i]}" != "string" ]] || [[ "${Array[i]}" != "PRIMARY" ]];
            then
                    printf "\t ${Array[i]}"
            fi
            printf "\n"
        done
        # Table Content Printing
        while read -r line; do
           set -- "${line}"
           IFS="|"; declare -a Array=($*)
           for (( i=0; i<${#Array[@]}; i++ ))
           do
                printf "\t ${Array[i]}"
           done
           printf "\n"
        done < "${TABLE_NAME}"
    else
        printf "#>\e[41m SYNTAX ERROR.\e[41m\n"
    fi
    read_commands
}

# TABLE META
# COL.NAME|DATATYPE|COL.NAME|DATATYPE|PRIMARY|COL.NAME

