module SessionsHelper
  def current_user
    #左の値がfalseかnilの場合に右の値を代入
    # @current_user = @current_user || User.find_by(id: session[:user_id])
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def logged_in?
    #current_user値が存在する場合は、trueを、nilの場合はfalseを返す
    #否定演算子を2回使ったもの。
    !!current_user
  end
  
  def store_location
    #ログインが必要なページにアクセス使用とした際に、ページのURLを
    #一旦保存しておき、ログイン画面に遷移してログイン後に再び保存したURLにアクセスする場合に
    #このメソッドを使用する
    session[:forwarding_url] = request.url if request.get?
  end
end
