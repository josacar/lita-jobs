require 'yajm/job_manager'

module Lita
  module Handlers
    class Jobs < Handler
      route /^jobs\slist$/, :job_list,
        :help => { 'jobs list' => t('help.job_list') }
      route /^jobs\skill\s(\d+)$/, :job_kill,
        :help => { 'jobs kill JOB_ID' => t('help.job_kill') }
      route /^jobs\stail\s(\d+)$/, :job_tail,
        :help => { 'jobs tail JOB_ID' => t('help.job_tail') }
      route /^jobs\sout(?:put)?\s(\d+)$/, :job_output,
        :help => { 'jobs out JOB_ID' => t('help.job_output') }

      def job_list(response)
        jobs = ::Yajm::JobManager.list
        if jobs[:active].length == 0 && jobs[:finished].length == 0
          response.reply(t('job_list.no_job'))
        else
          str = ''
          str << active_jobs(jobs[:active]) << finished_jobs(jobs[:finished])

          response.reply(str)
        end
      end

      def job_kill(response)
        in_job(response) do |job|
          job.kill!
        end
      end

      def job_tail(response)
        in_job(response) do |job|
          response.reply(job.output_tail)
        end
      end

      def job_output(response)
        in_job(response) do |job|
          response.reply(job.output)
        end
      end

      private

      def active_jobs(jobs)
        "".tap do |str|
          if jobs.length > 0
            str << "> #{t('job_list.active_jobs')}:\n"
            jobs.each do |job|
              str << "   ID: %d Cmd: '%s' #{t('job_list.started')}: %s\n" %
                [job.pid, job.command, job.start_time.to_s]
            end
            str << "\n"
          end
        end
      end

      def finished_jobs(jobs)
        "".tap do |str|
          if jobs.length > 0
            str << "> #{t('job_list.finished_jobs')}:\n"
            jobs.each do |job|
              str << "   ID: %d Cmd: '%s' #{t('job_list.started')}: %s, #{t('job_list.finished')}: %s\n" %
                [job.pid, job.command, job.start_time.to_s, job.end_time.to_s]
            end
          end
        end
      end

      def retrieve_job(job_id)
        Yajm::JobManager.getjob(job_id.to_i)
      end

      def in_job(response)
        job_id = response.matches[0][0]
        job = retrieve_job(job_id)
        if job
          yield(job)
        else
          response.reply(t('in_job.no_job', job_id: job_id))
        end
      end
    end

    Lita.register_handler(Jobs)
  end
end
