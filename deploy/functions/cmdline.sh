source ${BASH_SOURCE%/*}/usage.sh

cmdline() {

    # got this idea from here:
    # http://kirk.webfinish.com/2009/10/bash-shell-script-to-use-getopts-with-gnu-style-long-positional-parameters/
    local arg=
    for arg
    do
        local delim=""
        case "$arg" in
            #translate --gnu-long-options to -g (short options)
            --help)         args="${args}-h ";;
            --destroy)      args="${args}-d ";;
            --env)          args="${args}-e ";;
            #pass through anything else
            *) [[ "${arg:0:1}" == "-" ]] || delim="\""
                args="${args}${delim}${arg}${delim} ";;
        esac
    done

    #Reset the positional parameters to the short options
    eval set -- $args

    while getopts ":e:hd" opt; do
      case $opt in
        h)
          usage
          exit
          ;;
        d)
          readonly DESTROY=1
          ;;
        e)
          readonly ENVIRONMENT=$OPTARG
          ;;
        \?)
          echo -e  "${RED}Invalid option: -$OPTARG ${NC}" >&2
          usage
          exit 1
          ;;
        :)
          echo -e  "${RED}Option -$OPTARG requires an argument.${NC}" >&2
          exit 1
          ;;
      esac
    done

    if [ -z $ENVIRONMENT ]; then
      echo -e "\n${RED}Missing environment parameter. Please supply via -e during execution.${NC}"
      usage
      exit 1
    fi

    return 0

}