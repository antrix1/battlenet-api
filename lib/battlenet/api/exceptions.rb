module Battlenet
  # A general Battlenet exception
  class Error < StandardError; end

  class RateLimited < Error
    attr_accessor :message, :qps_alloted, :qps_current, :qph_alloted, :qph_current, :limit_reset

    def initialize(message, qps_alloted, qps_current, qph_alloted, qph_current, limit_reset = nil)
      @message = message
      @default_message = "API Limited reached."      
      @qps_alloted = qps_alloted
      @qps_current = qps_current
      @qph_alloted = qph_alloted
      @qph_current = qph_current
      @limit_reset = limit_reset
    end

    def to_s
      @message || @default_message
    end
  end
end
