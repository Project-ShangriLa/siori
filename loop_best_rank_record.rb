counter = 0
while (true) do
        counter+=1
        puts counter
        system "bundle exec ruby dvd_best_rank_save_record.rb"
        sleep(60*60)
end