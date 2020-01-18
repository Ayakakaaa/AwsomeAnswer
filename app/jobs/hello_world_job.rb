class HelloWorldJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    puts"----------------------"
    puts "Running a job ..🤸‍♀️"
    puts "---------------------"
  end

  # To run a job, use any of the following methods:
  # <JobClass>.perform_now(<args>)
  # This will run the job synchronously (or in the foreground) meaning
  # that it will not be in the queue. If it is called from Rails, Rails
  # would execute the job instead of a worker.
  # <JobClass>.perform_later(<args>)
  # This will insert the job in your queue to be executed by
  # a worker.
  # To perform jobs at a given time, use the set method:
  # <JobClass>.set(<some-kind-of-time>)
  # HelloWorld.set(wait: 10.minutes).perform_later
  # The above will insert a job in queue that will only
  # run after 10 minutes have elapsed.
  # HelloWorldJob.set(run_at: 1.week.from_now).perform_later
  # To see more options, check out the documentation on ActiveJob:
  # http://guides.rubyonrails.org/active_job_basics.html

end
