task :enqueue_feed_eater_worker, [:feed_onestop_ids] => [:environment] do |t, args|
  begin
    if args.feed_onestop_ids.present?
      array_of_feed_onestop_ids = args.feed_onestop_ids.split(' ')
    else
      array_of_feed_onestop_ids = []
    end
    feed_eater_worker = FeedEaterWorker.perform_async(array_of_feed_onestop_ids)
    if feed_eater_worker
      puts "FeedEaterWorker ##{feed_eater_worker} has been created and enqueued."
    else
      raise 'FeedEaterWorker could not be created or enqueued.'
    end
  rescue
    puts "Error: #{$!.message}"
    puts $!.backtrace
  end
end