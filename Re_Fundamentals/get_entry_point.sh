#!/bin/bash

# Check if a file is provided as an argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <ELF file>"
    exit 1
fi

# Check if the file exists
if [ ! -f "$1" ]; then
    echo "Error: File '$1' does not exist."
    exit 1
fi

# Check if the file is a valid ELF file
if ! file "$1" | grep -q "ELF"; then
    echo "Error: File '$1' is not a valid ELF file."
    exit 1
fi

# Extract information using readelf
magic_number=$(readelf -h "$1" | awk '/Magic:/ {for (i=2; i<=NF; i++) printf $i " "; print ""}')
class_format=$(readelf -h "$1" | awk '/Class:/ {print $2}')
byte_order=$(readelf -h "$1" | awk '/Data:/ {print $2, $3, $4}')
entry_point=$(readelf -h "$1" | awk '/Entry point address:/ {print $4}')

# Display the extracted information
echo "ELF Header Information for '$1':"
echo "--------------------------------"
echo "Type of Magic Number: $magic_number"
echo "Indicates the Class or Format: $class_format"
echo "Specifies the Byte Order: $byte_order"
echo "Entry Point Address: $entry_point"
