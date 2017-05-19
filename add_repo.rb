require 'yaml'

def usage
  puts 'usage:'
  puts 'ruby add_repo.rb "emberjs/guides"'
  exit
end

def already
  puts "Repo #{ARGV[0]} already in list"
  exit
end


def start
  repo = ARGV[0]
  usage if repo.nil?
  parts = repo.split(/\//)
  usage if parts.length != 2

  repos = YAML.load_file('./repos.yml')

  all_repos = []
  all_repos += repos['todo']
  all_repos += repos['open']
  all_repos += repos['merged']
  all_repos += repos['notodo']

  already if all_repos.map{|r|r['name']}.include? repo

  repos["todo"] << {
    "name" => repo,
    "branch" => nil
  }

  File.open('./repos.yml', 'wb') do |f|
    f.write repos.to_yaml
  end

  `sh updateReadme.sh`
end




start
