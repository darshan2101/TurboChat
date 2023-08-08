class TurboDeviseController < ApplicationController
  class Responder < ActionController::Responder
    def to_turbo_stream
      rendering_options = options.merge(formats: :html)
      controller.render(rendering_options)
    rescue ActionView::MissingTemplate => error
      if get?
        raise error
      elsif has_errors? && default_action
        rendering_options = rendering_options.merge(formats: :html, status: :unprocessable_entity)
        controller.render(rendering_options)
      else
        redirect_to navigation_location
      end
    end
  end

  self.responder = Responder
  respond_to :html, :turbo_stream
end
