require "spec_helper"

describe Lita::Handlers::Jobs, lita_handler: true do
  let(:running_job1) do
    instance_double(Twke::Job,
      :pid => 123,
      :command => 'shutdown',
      :start_time => Time.parse('Thu Nov 29 14:33:20 GMT 2001')
    )
  end
  let(:finished_job1) do
    instance_double(Twke::Job,
      :pid => 3131,
      :command => 'last',
      :start_time => Time.parse('Thu Jan 19 14:33:20 GMT 2013'),
      :end_time => Time.parse('Thu Jan 19 15:33:20 GMT 2013')
    )
  end
  let(:job) { instance_double(Twke::Job) }
  let(:empty_jobs) do
    { :active => [], :finished => [] }
  end
  let(:active_jobs) do
    { :active => [running_job1], :finished => [] }
  end
  let(:finished_jobs) do
    { :active => [], :finished => [finished_job1] }
  end

  it { routes('jobs list').to(:job_list) }
  it { routes('jobs kill 1231').to(:job_kill) }
  it { routes('jobs tail 2231').to(:job_tail) }
  it { routes('jobs output 232').to(:job_output) }
  it { routes('jobs out 232').to(:job_output) }
  it { doesnt_route('jobs wadus').to(:job_list) }

  shared_examples_for 'prints error message when job not found' do
    it 'returns error message when not found' do
      allow(Twke::JobManager).to receive(:getjob).with('1123')
      send_command('jobs tail 1123')
      expect(replies.last).to eq('No such job: 1123')
    end
  end

  describe '#job_list' do
    it 'returns no job if there is no job' do
      allow(::Twke::JobManager).to receive(:list).and_return(empty_jobs)
      send_command('jobs list')
      expect(replies.last).to eq('No active or finished jobs.')
    end

    it 'returns active jobs list for running jobs' do
      allow(::Twke::JobManager).to receive(:list).and_return(active_jobs)
      send_command('jobs list')
      expect(replies.last).to eq("> Active Jobs:\n   ID: 123 Cmd: 'shutdown' Started: 2001-11-29 15:33:20 +0100\n\n")
    end

    it 'returns finished jobs list for finished jobs' do
      allow(::Twke::JobManager).to receive(:list).and_return(finished_jobs)
      send_command('jobs list')
      expect(replies.last).to eq("> Finished Jobs:\n   ID: 3131 Cmd: 'last' Started: 2013-01-19 15:33:20 +0100, Finished: 2013-01-19 16:33:20 +0100\n")
    end
  end

  describe '#job_kill' do
    it 'kills a jobs when found' do
      allow(Twke::JobManager).to receive(:getjob).with('1123').and_return(job)
      expect(job).to receive(:kill!)
      send_command('jobs kill 1123')
    end

    it_behaves_like 'prints error message when job not found'
  end

  describe '#job_tail' do
    it 'gets last output from a job when found' do
      output = 'Hello world!'
      allow(Twke::JobManager).to receive(:getjob).with('1123').and_return(job)
      allow(job).to receive(:output_tail).and_return(output)
      send_command('jobs tail 1123')
      expect(replies.last).to eq(output)
    end

    it_behaves_like 'prints error message when job not found'
  end

  describe '#job_output' do
    it 'gets output from a job when found' do
      output = "I'm Muzzy big Muzzy"
      allow(Twke::JobManager).to receive(:getjob).with('1123').and_return(job)
      allow(job).to receive(:output).and_return(output)
      send_command('jobs output 1123')
      expect(replies.last).to eq(output)
    end

    it_behaves_like 'prints error message when job not found'
  end
end
