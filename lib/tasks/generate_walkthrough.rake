# lib/tasks/generate_walkthrough.rake
namespace :awanllm do
  desc 'Generate walkthrough using AwanLLM'
  task :generate_walkthrough => :environment do
    awanllm = WalkthroughAwanllm::AwanLLM.new
    awanllm.generate_walkthrough
  end
end
