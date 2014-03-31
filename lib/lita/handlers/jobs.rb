module Lita
  module Handlers
    class Jobs < Handler
      route /^jobs\slist$/, :job_list
      route /^jobs\skill\s(\d+)$/, :job_kill
      route /^jobs\stail\s(\d+)$/, :job_tail
      route /^jobs\sout(put)?\s(\d+)$/, :job_output
    end

    Lita.register_handler(Jobs)
  end
end
