require 'getoptlong'

opts = GetoptLong.new(
  [ '--existing-box', GetoptLong::OPTIONAL_ARGUMENT ]
)

$USE_EXISTING_BOX=false
$PROVISIONING_REQUIRED=true
$EXISTING_BOX_NAME=''

opts.each do |opt, arg|
  case opt
    when '--existing-box'
      $USE_EXISTING_BOX=true
      $PROVISIONING_REQUIRED=false
      $EXISTING_BOX_NAME=arg
  end
end
