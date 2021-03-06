defmodule Reg1Web.Router do
  use Reg1Web, :router
  ## use Phoenix.Router
  use Pow.Phoenix.Router
  use Pow.Extension.Phoenix.Router,
    extensions: [PowResetPassword, PowEmailConfirmation]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end



       if Mix.env == :dev do
    # If using Phoenix
       forward "/sent_emails", Bamboo.SentEmailViewerPlug

    #  If using Plug.Router, make sure to add the `to`
    #  forward "/sent_emails", to: Bamboo.SentEmailViewerPlug
       end
 

  scope "/" do
    pipe_through :browser

    pow_routes()
    pow_extension_routes()
  end


  scope "/", Reg1Web do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/", Reg1Web do
    pipe_through [:browser, :protected]

    resources "/tasks", TaskController    
  end

  scope "/", Reg1Web do
    pipe_through [:browser, :protected]

    resources "/parrots", ParrotController    
  end

  # Other scopes may use custom stacks.
  # scope "/api", Reg1Web do
  #   pipe_through :api
  # end
end
