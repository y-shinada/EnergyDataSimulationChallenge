namespace :hello_energy do
  namespace :deploy do
    task :cleanup_uncompile_assets do
      on roles(:web) do
        subdirs = Dir.glob('app/assets/javascripts/**/**.js').map { |f| shared_path.join(File.dirname(f.gsub(/\Aapp/, 'public'))) }.uniq
        subdirs.each do |f|
          info "Cleanup #{f}"
          execute :rm, "-rf", f
        end
      end
    end
  
    task :deliver_uncompile_assets do
      on roles(:web) do
        Dir.glob('app/assets/javascripts/**/**.js').each do |f|
          subdir = shared_path.join(File.dirname(f.gsub(/\Aapp/, 'public')))
          execute :mkdir, "-p", subdir
          info "Uploading #{f} to public"
          upload! File.open(f), subdir.join(File.basename(f))
        end
      end
    end
  end
end
