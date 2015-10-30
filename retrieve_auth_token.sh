# At the moment there isn't a great way to programmatically obtain authentication tokens for an account from
# scratch. We will make this significantly easier as the API matures but for now this helps.

# Obtained by registering your application at https://developer.frontdeskhq.com
client_id=
client_secret=

# Host of the business to be queried, e.g. https://fdsc.frontdeshq.com
host=

# User name and password of *your* account. Your access to information will be determined by the access level
# of the profile for the business being queried.
user=
password=

cookie_jar=front_desk_cookies.txt

echo "obtaining sign in authenticity token..."

token=$(curl -b $cookie_jar -c $cookie_jar -s ${host}/accounts/sign_in | perl -n -e '/authenticity_token" type="hidden" value="([^"]+)"/ && print $1')

echo "signing in..."

curl -b $cookie_jar -c $cookie_jar -s -X POST -d "authenticity_token=${token}&account[email]=${user}&account[password]=${password}" ${host}/accounts/sign_in 2>&1 > /dev/null

echo "obtaining authorise authenticity token..."

token=$(curl -b $cookie_jar -c $cookie_jar -s -X GET -d "client_id=${client_id}&response_type=code&redirect_uri=http://foo.com" ${host}/oauth/authorize | perl -n -e '/authenticity_token" type="hidden" value="([^"]+)"/ && print $1')

echo "authorising..."

code=$(curl -b $cookie_jar -c $cookie_jar -s -D - -X POST -d "authenticity_token=${token}&authorize=1&client_id=${client_id}&response_type=code&redirect_uri=http://foo.com" ${host}/oauth/authorize | perl -n -e '/Location: .+?code=(\w+)/ && print $1')

echo "obtaining auth token..."

token=$(curl -b $cookie_jar -c $cookie_jar -s -D - -X POST -d "grant_type=authorization_code&client_id=${client_id}&client_secret=${client_secret}&code=${code}&redirect_uri=http://foo.com" ${host}/oauth/token | perl -n -e '/access_token":"([^"]+)/ && print $1')

echo "  your auth token for ${host} is ${token}"
