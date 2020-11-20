# frozen_string_literal: true

module Benchmark
  module Memory
    class Job
      # Swallow all output from a job.
      class NullOutput
        # Swallow entry output.
        #
        # @return [void]
        def put_entry(entry); end

        # Swallow comparison output.
        #
        # @return [void]
        def put_comparison(comparison); end

        # Swallow header output.
        #
        # @return [void]
        def put_header; end
      end
    end
  end
end
