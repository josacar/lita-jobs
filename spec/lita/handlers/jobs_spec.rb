require "spec_helper"

describe Lita::Handlers::Jobs, lita_handler: true do
  before do
  end

  it { routes('jobs list').to(:job_list) }
  it { routes('jobs kill 1231').to(:job_kill) }
  it { routes('jobs tail 2231').to(:job_tail) }
  it { routes('jobs output 232').to(:job_output) }
  it { routes('jobs out 232').to(:job_output) }
  it { doesnt_route('jobs wadus').to(:job_list) }
end
