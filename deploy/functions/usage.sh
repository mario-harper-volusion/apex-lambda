usage()
{
cat << EOF
usage: $PROGNAME options

SCRIPT EXPECTS:
  ENV vars to be set:
    AWS_DEFAULT_REGION
    ZIP_TAX_API_KEY

OPTIONS:
   -h --help        Show this help
   -d --destroy     Run a destroy?
   -e --env         The deploy environment (dev, int, prod)

EXAMPLES:
  Run a destroy on dev environment:
  $PROGNAME --destroy --env dev

EOF

  return 0

}