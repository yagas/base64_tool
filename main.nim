import os
import base64

proc show_help() =
    echo "Base64 Tool Version 1.1.0"
    echo "Copyright (c) 2022 by yagas <yagas@sina.com>"
    echo "::\n"
    echo "base64 command input output\n"
    echo "Command:"
    echo "  -c\t\tencode"
    echo "  -c:safe\tsafe-encode"
    echo "  -d\t\tdecode\n"
    echo "Arguments:"
    echo "  input\t\torigin file path"
    echo "  output\ttarget file path"
    echo "\nE.g. base64 -d .\\base64.txt .\\decode.pdf"



proc exec(params: seq[string]) =
    let command = params[0]
    let file_input = params[1]
    let file_output = params[2]
    if not os.fileExists(file_input):
        raiseAssert("Not Found input file")
    
    var target_code: string
    let origin_code = readFile(file_input)
    if command == "-c":
        target_code = base64.encode(origin_code)
    elif command == "-c:safe":
        target_code = base64.encode(origin_code, true) 
    else:
        target_code = base64.decode(origin_code)
    
    writeFile(file_output, target_code)


proc main() =
    let params = os.commandLineParams()
    if params.len != 3:
        show_help()
    else:
        try:
            exec(params)
            echo "Done.\n"
        except Exception as err:
            echo err.msg

main()