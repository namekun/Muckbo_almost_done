# 먹고보자 보고먹자 먹보 프로젝트 내용 정리.

# 1. Devise

## 1) 기본 명령어 

```ruby
$ rails g devise:installl
$ rails g devise:views users
$ rails g devise:controller users #controller를 따로 설정해줘야하는 경우에만 사용
```

 

## 2) Devise에 column 추가 

```ruby
 $ rails generate migration add_name_to_users name:string
```

```ruby
class CreateUserChatLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :user_chat_logs do |t|
      t.string :room_title
      t.integer :room_id
      t.integer :user_id
      t.string :nickname
      t.date :chat_date
      
      t.timestamps
    end
  end
end
```

- 위와같이 add_name_to_users로 하지 않고, devise users 모델에 column을 그냥 추가하면 정상작동하지 않는다. 반드시 위의 명령어로 devise에 column을 추가해야한다.



## 2)  View 구성

### (1) 로그인 화면

app > views > users > sessions > new.html.erb 

```ruby
<section class="flat-row flat-login parallax1" style="padding-top: 0px;padding-bottom: 0px;">
			<div class="container">
				<div class="row">
					<div class="col-lg-2">
					</div><!-- /.col-lg-2 -->
					<div class="col-lg-4 col-sm-6">
						<div class="login-form" style="font-family:Binggrae">
							<h3 style="font-family:Binggrae">또 같이 먹으러가자!</h3>
							<!--<form action="/users/sign_in" method="get" accept-charset="utf-8">-->
							<%= simple_form_for(resource, as: resource_name, url: session_path(resource_name)) do |f| %>
								<div class="wrap-login">
								    <%= f.label :email %><br />
								    <%= f.email_field :email, autofocus: true, autocomplete: "email" %>
								</div>
								<div class="wrap-login">
								    <%= f.label :password %><br />
								    <%= f.password_field :password, autocomplete: "off" %>
								</div>
								<div class="wrap-login remember">
									<a href="/users/sign_up" class="sign_up" title="" style="color: #ffffff;">가입하기</a>
									<a href="/users/password/new" class="forgot" title="">비밀번호를 잊으셨나요?</a>
								</div>		
								<br>
								<% flash.each do |key, message| %>
									<h5><%= message %></h5>
								<% end %>
								<div class="btn-more" style="text-align: center;">
									<!--<button type ="submit" title="submit">로그인</button>-->
									<%= f.submit "Log in",style: "color: #ffffff;" %>
								</div>
								<% end %>
							</form><!-- /form -->
						</div><!-- /.login-form -->
					</div><!-- /.col-lg-4 -->
					<div class="col-lg-1">
					</div><!-- /.col-lg-1 -->
				</div><!-- /.row -->
			</div><!-- /.container -->
			<div class="overlay"></div>
		</section><!-- /.flat-login -->
		<% content_for 'javascript_content' do %>
<%= javascript_include_tag params[:controller] %>
<% end %>
```



### (2) 회원가입 화면

app > views > users > registrations > new.html.erb

```ruby

	<section class="flat-row flat-login style2 parallax1" style="padding-top: 0px;padding-bottom: 0px;">>
			<div class="container">
				<div class="row">
					<div class="col-lg-2">
					</div><!-- /.col-lg-2 -->
					<div class="col-lg-4 col-sm-6">
						<div class="login-form style2" style="font-family:Binggrae">
							<h3 style="font-family:Binggrae">회원가입</h3>
						    
							<!--<form action="/create" method="POST" accept-charset="utf-8">-->
							<%= form_for(resource, as: resource_name, url: registration_path(resource_name)) do |f| %>
								<% if resource.errors.messages[:nickname][1] == "닉네임이 이미 존재합니다." %>
									<h6>해당 닉네임이 이미 존재합니다.</h6>
								<% end %>
								<% if resource.errors.messages[:email][0] == "has already been taken" %>
									<h6>해당 이메일이 존재합니다.</h6>
								<% end %>
								<% if resource.errors.messages[:email][0] == "can't be blank" %>
									<h6>이메일이 비어있습니다.</h6>
								<% end %>
								<% if resource.errors.messages[:password][0] == "can't be blank" %>
									<h6>비밀번호가 비어있습니다.</h6>
								<% end %>
								<% if resource.errors.messages[:password_confirmation][0] == "doesn't match Password" %>
									<h6>비밀번호가 일치하지 않습니다.</h6>
								<% end %>
							   <input type="hidden" name="authenticity_token" value="<%= form_authenticity_token %>">
							   <br>
								<div class="wrap-login">
									<%= f.label :"학교이메일" %>
    								<%= f.email_field :email, autofocus: true, autocomplete: "email", required: true  %>
								</div>
								<div class="wrap-login">
									<%= f.label :"비밀번호", required: true  %>
								    <% if @minimum_password_length %>
								    <em>(<%= @minimum_password_length %> 글자 이상이여야 합니다.)</em>
								    <% end %>
								    <%= f.password_field :password, autocomplete: "off", required: true  %>
								</div>
								<div class="wrap-login">
								    <%= f.label :"비밀번호 확인" %>
    								<%= f.password_field :password_confirmation, autocomplete: "off" %>
								
    							</div>
								<div class="wrap-login">
									<%= f.label :"닉네임" %>
									<%= f.text_field :nickname, autofocus: true, autocomplete: "off", required: true %>
								</div>
								<div class="wrap-login">
									<%= f.label :"핸드폰번호" %>
									<%= f.text_field :phone, autofocus: true, autocomplete: "off", required: true %>
								</div>
								<div class="wrap-login">
									<%= f.label :"주전공" %>
									<%= f.text_field :major, autofocus: true, autocomplete: "off", required: true %>
								</div>
								<div class="wrap-login">
									<%= f.label :"연계/복수/부전공" %>
									<%= f.text_field :another_major, autofocus: true, autocomplete: "off", required: true %>
								</div>
								<div class="wrap-login" >
									<%= f.label :"성별" %>
									<!--<1%= f.select(:sex), :html => { :style="color: white;border: 1px solid #ffffff;border-radius: 5px;font-family:Binggrae" } do %>-->
									<!--  <1% [['남', 'man'], ['여', 'woman']].each do |c| -%>-->
									<!--    <1%= content_tag(:option, c.first, value: c.last) %>-->
									<!--  <1% end %>-->
									<%= f.select :sex, [['성별', 'null'], ['남', 'man'], ['여', 'woman']], {:disabled => 'null', :selected => 'null'}, {:style =>"color:white;border:1px solid #ffffff;border-radius:5px;font-family:Binggrae"} %>  
							
								</div>
								<br/>
								<div class="actions center" >
								  <%= f.submit "가입하기",style: "color:white" %>
								</div>
							<% end %>
							<!--</form>--><!-- /form -->
						</div><!-- /.login-form style2 -->
					</div><!-- /.col-lg-4 col-sm-6 -->
					<div class="col-lg-1">
					</div><!-- /.col-lg-1 -->
				</div><!-- /.row -->
			</div><!-- /.container -->
			<div class="overlay"></div>
		</section><!-- /.flat-login style2 -->
		<% content_for 'javascript_content' do %>
<%= javascript_include_tag params[:controller] %>
<% end %>
		
```

- `<% if resource.errors.messages[:email][0] == "has already been taken" %> `와 같이 에러를 검색하여 잡은 이유는 config/locales/devise.en.yml 파일 내부에서 처리하는 오류가 아니라 errors 객체 자체에 존재하는 에러이기 때문에 따로 검색해서 잡아내야 했다.

  

### (3) 비밀번호 찾기 화면

app > views > users > passwords > new.html.erb

```ruby
<section class="flat-row flat-login parallax1" style="padding-top: 0px;padding-bottom: 0px;">
            <div class="container">
                <div class="row">
                    <div class="col-lg-2">
                    </div><!-- /.col-lg-2 -->
                    <div class="col-lg-4 col-sm-6">
                        <div class="login-form" style="font-family:Binggrae">
             <h3 style="font-family:Binggrae">비밀번호 찾기</h3>
         <%= simple_form_for(resource, as: resource_name, url: password_path(resource_name), html: { method: :post }) do |f| %>
         
           <div class="wrap-login">
             <%= f.input :email, required: true, autofocus: true %>
           </div>
         
           <div class="wrap-login">
             <%= f.button :submit, "비밀번호 찾기 메일 발송" %>
           </div>
         <% end %>
                        </div><!-- /.login-form -->
                    </div><!-- /.col-lg-4 -->
                    <div class="col-lg-1">
                    </div><!-- /.col-lg-1 -->
                </div><!-- /.row -->
            </div><!-- /.container -->
            <div class="overlay"></div>
        </section><!-- /.flat-login -->
```



### (4) 비밀번호 수정화면

app > views > users > passwords > edit.html.erb

```ruby
<section class="flat-row flat-login parallax1" style="padding-top: 0px;padding-bottom: 0px;">
            <div class="container">
                <div class="row">
                    <div class="col-lg-2">
                    </div><!-- /.col-lg-2 -->
                    <div class="col-lg-4 col-sm-6">
                        <div class="login-form" style="font-family:Binggrae">
             <h3 style="font-family:Binggrae">비밀번호 찾기</h3>
             
             <%= simple_form_for(resource, as: resource_name, url: password_path(resource_name), html: { method: :put }) do |f| %>
             
               <%= f.input :reset_password_token, as: :hidden %>
               <%= f.full_error :reset_password_token %>
             
                <div class="wrap-login">
                 <%= f.input :password, label: "새 비밀번호", required: true, autofocus: true, hint: ("#{@minimum_password_length} characters minimum" if @minimum_password_length) %>
                 <%= f.input :password_confirmation, label: "비밀번호 확인", required: true %>
                </div>
               <br>
               <br>
                <div class="wrap-login">
                 <%= f.button :submit, "비밀번호 변경" %>
               </div>
             <% end %>
           </div><!-- /.login-form -->
                    </div><!-- /.col-lg-4 -->
                    <div class="col-lg-1">
                    </div><!-- /.col-lg-1 -->
                </div><!-- /.row -->
            </div><!-- /.container -->
```



# 2. Javascript 및 CSS적용

app > javascripts > chat.js

```ruby
(function(){
    var chat  = { ... };
    chat.init();
    var searchFilter = { ... };
    searchFilter.init();
    })();
```

- codepen 사이트에서 가져온 js 파일을 그대로 복붙함.

app > stylesheets > chat.scss

```ruby
@import url(https://fonts.googleapis.com/css?family=Lato:400,700);

$green: #86BB71;
$blue: #94C2ED;
$orange: #E38968;
$gray: #92959E;

*, *:before, *:after {
  box-sizing: border-box;
}

                    ...
    
@font-face { font-family: 'KHNPHD'; src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/KHNPHD.woff') format('woff'); 
    font-weight: normal; font-style: normal; } // 한돋움체
```



config > initializers > assets.rb

```ruby
# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( rooms.js
                                                  rooms.scss
                                                  devise/sessions.js
                                                  devise/sessions.css
                                                  chat.js
                                                  chat.scss
                                                  users/registrations.js
                                                  users/registrations.css
                                                  devise/passwords.js)

```

- 위에서 설정한 파일을 적용하기 위해 assets.rb파일에 해당파일을 사용할 것을 알린다.



# 3. layout 설정

rooms_controller.rb

```ruby
class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy, :user_exit_room, :is_user_ready, :chat, :open_chat]
  before_action :authenticate_user!, except: [:index]

  layout "chat", only: [:chat, :open_chat]
    ...
end
```

- before_action은 해당 컨트롤러를 사용하기 전에 값을 설정할 수 있게 해준다.
- layout "chat"을 쓴 이유는, layout > application.rb 파일 대신 layout > chat.rb 파일을 적용하기 위해서 사용했다.

app > views > layouts > chat.html.erb

```ruby
  <head>
    <title>Muckbo</title>
    <%= csrf_meta_tags %>
    <script src="https://js.pusher.com/4.1/pusher.min.js"></script>
  </head>
  
  <%= yield %>
```

- controller를 통해 chatting view로 넘겨줄 때, nav 및 footer를 제외하기 위해서 view의 layout을 변경.



# 4. 인증메일발송



## 1) 구글 계정 및 보안

1. 구글 계정 로그인 및 보안](https://myaccount.google.com/security)에 접속
2. 최하단 `보안 수준이 낮은 앱 허용: 사용` 체크를 통해 외부 앱에서 구글 계정에 접근할 수 있도록 설정



## 2) Rails email setup

1. `config/initializers/email_setup.rb` 파일을 만들고 다음의 내용을 추가함

```ruby
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default :charset => "utf-8"
ActionMailer::Base.smtp_settings = {
  address: "smtp.gmail.com",
  port: 587,
  authentication: "plain",
  enable_starttls_auto: true,
  user_name: ENV["GMAIL_USERNAME"],
  password: ENV["GMAIL_PASSWORD"]
}
```

2. figaro가 설치 되어 있다면 `config/application.yml` 에 `GMAIL_USERNAME` 과 `GMAIL_PASSWORD` 항목을 추가하고 #1에서 설정했던 계정정보를 적어준다.

```ruby
GMAIL_USERNAME: "...@gmail.com"
GMAIL_PASSWORD: "....."
```



3. 개발 환경에서는 `config/environments/development.rb` 

```ruby
...
    config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
	config.action_mailer.raise_delivery_errors = true # 기존 false
...
```

배포 환경에서는 `config/environments/production.rb`

```ruby
...
    config.action_mailer.default_url_options = { host: IP Address, port: 443 }
...
```



## 3) Generate Rails Mailer

① `$ rails g mailer ContactMailer` 를 통해 mailer 생성

② `mailers/contact_mailer.rb` 설정

```ruby
class ContactMailer < ApplicationMailer
  default from: "muckbo@muckbo.com" # 기본 발신자
  def contact_mail(mail_params)
    @user_mail = mail_params[:email]
    @subject = "먹보로 부터 도착한 contact 메일"
    @message = mail_params[:message]
    # 각각 메일 내용에 들어가야 할 부분들을 인스턴스 변수로 만들어줌
    mail(from: "muckbo@muckbo.com", to: @user_mail, subject: @subject)
  end
end
```

③ `views/contact_mailer/contact_mail.html.erb` 와 `contact_mail.text.erb` 생성

```ruby
<p>안녕하세요!</p>
<p>먹보에 오신것을 환영합니다</p>
<p>아래의 '인증하기' 버튼으로 가입을 완료하시기 바랍니다.</p>
<p><%= link_to '인증하기', confirmation_url(@resource, confirmation_token: @token) %></p>
```

④ `ContactMailer.contact_mail(mail_params).deliver_now` 를 통해 메일을 발송



# 5. 해쉬태그 

- DB, Model 생성

```
rails g model Room 
rails g tag name:string
rails g migration CreateRoomsTags Room:references Tag:references
```

- CreateRoomsTags 수정

```ruby
class CreateRoomsTags < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms_tags, :id => false do |t|
      t.references :room, foreign_key: true
      t.references :tag, foreign_key: true
    end
  end
end

```

- 여기서 `:id => false`가 추가된 부분.
- Room.rb , Tag.rb에 다음과 같이 추가해준다.

```ruby
#Room.rb
...    
has_and_belongs_to_many :tags
...
   
#Tag.rb
...
has_and_belongs_to_many :rooms
...
```

- Room.rb에 다음과 같은 코드를 추가해준다

```ruby
# 해시 태그 

# after_commit 콜백은 1개의 트랜잭션에서 발생한 어떤 모델의 생성, 갱신, 삭제 뒤에 호출됩니다. 
# 이 콜백들 중 어떤 것 하나라도 예외를 발생시키면, 실행되지 않은 나머지 콜백들은 실행되지 않습니다. 
after_commit :scan_hashtag_from_body, on: :create
after_commit :update_hashtag_from_body, on: :update

 def update_hashtag_from_body
   room = Room.find_by(id: self.id)
     hashtags = self.hashtag.split('#') # "#"기준으로 잘라낸다.
     transaction do 
        hashtags[1..-1].map do |hashtag|
            next if self.tags.where(name: hashtag).first
            tag = Tag.find_or_create_by(name: hashtag.downcase.strip)
            RoomsTag.create(room_id: self.id, tag_id: tag.id)
        end
     end 
 end

 def scan_hashtag_from_body
    room = Room.find_by(id: self.id)
    hashtags = self.hashtag.split('#')
    transaction do
        hashtags[1..-1].map do |hashtag|
            tag = Tag.find_or_create_by(name: hashtag.downcase.strip)
            RoomsTag.create(room_id: self.id, tag_id: tag.id)
        end
    end
 end
```

- 해시태그를 링크처럼 이용할 수 있도록 한다.
- 우선 hashtag를 눌렀을 때, 해당하는 hashtag만 나오는 화면을 만들어준다.

*views/rooms/hashtag.html.erb*

```erb
...
<section class="style3 flat-row">
			<div class="container">
				<div class="row">
					<div class="col-md-12">			
						<div class="filter-result style2" style="font-family:Binggrae">
							<div class="result">
	<span style="font-family:Binggrae"><font size="4">#<%=@tag%>에 해당되는 <%= @rooms.count %>개의 방이 있습니다!</font></span> <!--검색된 방의 갯수로 바꾸기--> 
							</div>
<span style="float:right;font-family:Binggrae"><font size="4"><%=link_to '방만들기', new_room_path %></font></span>
						</div><!-- /.filter-result -->
					</div><!-- /.col-md-12 -->
				</div><!-- /.row -->
					<% @rooms.each do |room| %>
				<div class="style3" style= "font-family:Binggrae">
					<div= "row">
						<div class="col-sx-12">
							<div class="imagebox style2">
								<div class="container ">
									<div class="box-header">
									</div><!-- /.box-header -->
									<div class ="row">
										<div>
		<a href ="/rooms/<%=room.id%>" ><font size="5"><%= room.room_title %></font></a>
			<span style="float:right;font-family:Binggrae"><font size="5"><%=room.admissions_count%>/<%=room.max_count%></font></span>
										</div>
										
										<div style ="font-family:Binggrae">
	<span style="color:black" class ="col"><font style="font-family:Binggrae" size="4"><%= room.start_time_hour%>:<%= room.start_time_min %>에 보자!</font></span>
	<div style="float:right;"><span><font size="5"><%= room.food_type %></font></span></div>
										</div>
									
										<div class="Hashtag" style="font-family:Binggrae">
											<span>
				<% room.tags.each do |tag| %>
				<%= link_to "##{tag.name}", "/rooms/hashtags/#{tag.name}" %>
				<% end %>
											</span>
										</div>
									</div><!-- /.box-content -->
								</div><!-- /.box-imagebox -->
							</div><!-- /.imagebox style2 -->
						</div><!-- /.col-sm-12 -->
					</div>		
						<% end %>
...
```

- 다음과 같이 hashtag가 보일 화면의 Route도 지정해준다.

*routes.rb*

```ruby
  get 'rooms/hashtags/:name' => 'rooms#hashtags'
```

- rooms_controller에 Hashtag 기능을 추가해준다.

```ruby
  def hashtags
    tag = Tag.find_by(name: params[:name])
    @rooms = tag.rooms
    @tag =tag.name
  end
```

- index.html.erb에 방마다 hashtag가 뜰 수 있도록 다음과 같이 입력한다.

*views/rooms/index.html.erb*

```erb
<div style ="font-family:Binggrae">
	<span style="color:black" class ="col"><font style="font-family:Binggrae" size="4">
        <%= room.start_time_hour%>:<%= room.start_time_min %>에 보자!</font></span>
		<div style="float:right;"><span><font size="5"><%= room.food_type %></font></span></div>
	</div>
<div class="Hashtag" style="font-family:Binggrae">
			<span>
				<% room.tags.each do |tag| %>
					<%= link_to "##{tag.name}", "/rooms/hashtags/#{tag.name}" %>
						<% end %></span>
									</div>
										</div><!-- /.box-content -->
```

- 방만드는 화면에서 hashtag를 입력받을 수 있도록 다음과 같이 입력칸을 만들어주도록 하자

*views/rooms/new.html.erb*

```ruby
	<div class="clearfix"></div>
		<div class="wrap-listing hashtag">
			<label>해쉬태그</label>
			<input type="text" name="room[hashtag]" placeholder="# 먼저 입력하시고 내용을 입력해주세요(최소 1개 이상)" required>
			 </div><!-- /.wrap-listing -->
```





# 6. 빠른 매칭

*rooms_Controller.rb*

```ruby
  def quickmatch
  end
  
  def matching
    if !Room.where(room_type: "먹방").to_a[0].nil? # 만약 먹방에 해당하는 방이 있다면
      match_num = 0 #순차적으로 방을 찾기 위해 쓰이는 변수
      if Room.where(room_type: "먹방").size > 1 # 만약 룸타입이 "먹방"인 방이 한개보다 많다면
        while match_num < Room.where(room_type: "먹방").to_a.length # match_num은 룸타입 "먹방"의 개수보다 크거나 같아질 때까지 loop문을 돌린다.
          if Room.where(room_type: "먹방").order(admissions_count: :desc)[match_num].admissions_count < Room.where(room_type: "먹방").order(admissions_count: :desc)[match_num].max_count # 룸타입이 먹방인 방중에서, 현재인원에 따라 역순으로 정렬한 방 중,  match_num번의 방의 현재인원이 해당 방의 max_count방보다 적을 때
    @rooms = Room.where(room_type: "먹방").order(:admissions_count).reverse.sort[match_num].id 
     # 룸타입이 먹방인 방에서, 현재 인원의 역순으로 정렬후, 인덱스에 따라서 다시 정렬, 그후 id 추출
            redirect_to "/rooms/#{@rooms}" # 해당하는 방으로 바로 이동할 수 있도록 한다.
            breaK; # while loop 탈출
          else # 아니라면
            match_num += 1 # match_num을 + 1 해준다.
          end
        end
      else # 만약 "먹방"타입의 방이 1개뿐 이라면
        if Room.where(room_type: "먹방")[0].admissions_count == Room.where(room_type:"먹방")[0].max_count # 근데 그 방의 현재인원과 최대인원이 같다면?
          flash[:danger] = "매치할 방이 없습니다..방을 직접 만들거나 잠시후 다시 시도해주세요!"
          redirect_to quickmatch_path # toastr을 띄우고 다시 빠른 매칭화면으로
        else
          @rooms = Room.where(room_type: "먹방")[0].id # 같지않다면 바로 매칭으로.
          redirect_to "/rooms/#{@rooms}"
        end
      end
    else # 룸타입이 "먹방"에 해당하는 방이 없다면
      flash[:danger] = "매치할 방이 없습니다..방을 직접 만들거나 잠시후 다시 시도해주세요!"
      redirect_to quickmatch_path
    end  
  end
```

*views/rooms/quickmatch.html.erb*

```erb
<section class="style3 flat-row">
	<div class="container">
            <div class="col-sm-12">
                        <br>
                        <br>
                    </div>
					<h1 class = "main center" style="font-family:Binggrae">빠른 매칭</h1>
                    <br/><br/>
                    <div class="center">
                        <img src="<%= asset_path 'icon/quick.png'%>" alt=""%>
                    </div>
                    <br>
                    <br>
                    <div class="center">
                        <br/>
                        <h4 style="font-family:Binggrae">빨리 밥먹고싶다구요?<br/>
                        그래서 준비했어요!</h4>
                    </div>
                 <div class="row">
						<div class="col-md-12">
							<div class="btn-more" style="margin-bottom: 50px;">
								<a href="/matching" title="" style="font-family:Binggrae">
									밥먹으러 갑시다!</a>
							</div>
						</div>
					</div><!-- /.row -->
            </div>
        </section>
```

*routes.rb*

```ruby
  get '/quickmatch' => 'rooms#quickmatch'
  get '/matching'=>'rooms#matching'
```





# 7. 다중 검색

- index에서 보이는 방이름, 음식타입, 룸타입을 복합적으로 모두 검색할 수 있는 검색엔진을 만들어보자.

*room_scontroller.rb*

```ruby
  def search
    if params[:hashsearch] and params[:room_type] and params[:food_type]
      @rooms = Room.where("room_title LIKE ?", "%#{params[:hashsearch]}%").where(room_type: params[:room_type], food_type: params[:food_type]).to_a 
    elsif params[:food_type] and params[:room_type]
      @rooms = Room.where(food_type: params[:food_type], room_type: params[:room_type]).to_a
    elsif params[:hashsearch] and params[:room_type]
      @rooms = Room.where("room_title LIKE ?", "%#{params[:hashsearch]}%").where(room_type: params[:room_type]).to_a 
    elsif params[:hashsearch] and params[:food_type]
      @rooms = Room.where("room_title LIKE ?", "%#{params[:hashsearch]}%").where(food_type: params[:food_type]).to_a 
    elsif params[:hashsearch]
      @rooms = Room.where("room_title LIKE ?", "%#{params[:hashsearch]}%").to_a
    elsif params[:food_type]
      @rooms = Room.where(food_type: params[:food_type]).to_a
    elsif params[:room_type]
      @rooms =  Room.where(room_type: params[:room_type]).to_a
    end
  end
```

- 다음과 같이 모든 3가지 조건(방 이름 검색, 음식 타입에 따라 방 검색, 룸 타입에 따른 방 검색)의 조건을 모두 if, elsif, else로 걸러준다.
- 검색 결과가 나오는 화면을 따로 작성해주자.

*views/rooms/search.html.erb*

```erb
 ...
						<div class="wrap-box-search style1 mb-3">
							<form action="/search" method="get" accept-charset="utf-8">
								<span>
							<input type="text" placeholder="방검색" name="hashsearch">
								</span>
								<span class="categories" >
									<span class="ti-angle-down"></span>
									<select name="food_type">
						<option value="" disabled selected>어떤 음식을 먹고싶은가요?</option>
										<option value="한식">한식</option>
										<option value="중식">중식</option>
										<option value="일식">일식</option>
										<option value="양식">양식</option>
										<option value="분식">분식</option>
										<option value="아시안">아시안</option>
										<option value="간편식">간편식</option>
										<option value="육식">육식</option>
									</select>
								</span>
								<span class="categories">
									<span class="ti-angle-down"></span>
									<select name="room_type">
							 <option value="" disabled selected>왜 만나실건가요?</option>
										<option value="정보교류">정보교류</option>
										<option value="먹방">혼밥매칭</option>
									</select>
								</span>
								<div class="input-group-append">
								<button type="submit" class="search-btn">Search</button>
								</div>
							</form><!-- /form -->
						</div><!-- /.wrap-box-search -->
					</div><!-- /.col-md-12 -->
				</div><!-- /.row -->
			</div><!-- /.container -->
			<div class="overlay"></div>
		</section><!-- /.page-title -->
		
		<section class="style3 flat-row">
			<div class="container">
				<div class="row">
					<div class="col-md-12">			
						<div class="filter-result style2" style="font-family:Binggrae">
							<div class="result">
								<span style="font-family:Binggrae"><font size="4">검색결과에 해당되는 <%= @rooms.count %>개의 방이 있습니다!</font></span> <!--검색된 방의 갯수로 바꾸기--> 
							</div>
...

```

# 8. 채팅방 만들어 질 때, 1시간 뒤에 채팅방 폭파

- 여기서는 active job을 사용해보도록한다. 
- Active Job은 잡을 선언하고, 이를 이용하여 큐를 사용하는 백엔드에서 다양한 방법으로 이를 처리하는 프레임워크다. 여기서 잡은 정기적으로 정기적으로 실행되는 작업이나, 인보이스 발행이나 메일 전송 등, 어떤 것이라도 가능하다. 이 작업들을 좀 더 작은 단위로 분할해서 병렬 실행할 수도 있다. 
- 우선 job을 만들어보자

```
$ rails generate job room_destroy
invoke  test_unit
create    test/jobs/room_destroy_job_test.rb
create  app/jobs/room_destroy_job.rb
```

- 만들어진 job클래스에 예약하고자 하는 기능을 넣어준다. 

```ruby
class RoomDestroyJob < ApplicationJob
  queue_as :default

  def perform(room_id)
    # Do something later
    Room.find(room_id).destroy
  end
end
```

- 이제 이 기능을 실행하고자 하는 곳에 이 코드를 넣어주면 끝!

*rooms_controller.rb*

```ruby
  def open_chat
   @room.update(room_state: true)
   @room.admissions.each do |admission|
   UserChatLog.create(room_title: @room.room_title, room_id: @room.id, user_id: 	admission.user_id, nickname: admission.user.nickname, chat_date: admission.updated_at.to_date )
   end

   Pusher.trigger("room_#{@room.id}", 'chat_start', {})
  
   RoomDestroyJob.set(wait: 1.hour).perform_later(@room.id) # 한시간 뒤에 방을 폭파하는 코드.
  end
```





# 9. 대기방 만들기 

## (1) Gem 파일설치 및 푸셔설치

*Gemfile*

```ruby
group :development do
   gem 'rails_db' 
end

# pusher
gem 'pusher'
# devise
gem 'devise'
# figaro
gem 'figaro'
```

> `gem 'turbolinks', '~> 5' ` 은 주석처리한다.
>
> **turbolink 삭제**
>
> 1. gem
> 2. application.js
> 3. application.html.erb 

*application.js*

```ruby
//= require jquery
//= require jquery_ujs
//= require popper
//= require bootstrap
```

> //= require turbolinks
> //= require_tree . -> 하위에 있는 모든 파일은 application.에 연결시킴.
>
> 이 두줄 삭제

- figaro 설치 : `figaro install`

- *application.yml*

  ```ruby
  development:
      Pusher_app_id: 
      Pusher_key: 
      Pusher_secret: 
      Pusher_cluster: 
  ```

- *~/workspace/config/initializers* 에 *pusher.rb* 만든다.

  ```ruby
  require 'pusher'
  
  Pusher.app_id = ENV["Pusher_app_id"]
  Pusher.key = ENV["Pusher_key"]
  Pusher.secret = ENV["Pusher_secret"]
  Pusher.cluster = ENV["Pusher_cluster"]
  Pusher.logger = Rails.logger
  Pusher.encrypted = true
  ```

- 푸셔 설치

  `$ gem install pusher`



## (2) 모델생성

```
$ rails g scaffold room
$ rails g model chat user:references room:references message:text
$ rails g model admission user:references room:references
```

*create_rooms.rb*

```ruby
class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.string   :room_title
      t.string   :master_id
      t.integer  :max_count
      t.integer  :admissions_count, default: 0
      t.boolean :room_state, default: false, null: false

      t.integer    :start_time_hour
      t.string    :start_time_min
      t.datetime    :meet_time_end
      t.string :hashtag
      t.string :food_type
      t.string :room_type    
      t.timestamps
    end
  end
end
```

*create_admissions.rb*

```ruby
class CreateAdmissions < ActiveRecord::Migration[5.0]
  def change
    create_table :admissions do |t|
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      t.boolean :ready_state, default: false, null: false

      t.timestamps
    end
  end
end
```

*create_chats.rb*

```ruby
class CreateChats < ActiveRecord::Migration[5.0]
  def change
    create_table :chats do |t|
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      t.text :message

      t.timestamps
    end
  end
end
```

- user 는 devise gem을 사용하였다. 

  

## (3) 다대다관계설정

*room.rb*

```ruby
    has_many :admissions
    has_many :users, through: :admissions
    has_many :chats
```

*admission.rb*

```ruby
  belongs_to :user
  belongs_to :room, counter_cache: true
```

*chat.rb*

```ruby
  belongs_to :user
  belongs_to :room
```

*user.rb*

```ruby
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :admissions
  has_many :rooms, through: :admissions
  has_many :chats
```



## (4) index화면 외에 접근하는 유저는 로그인을 해야한다. -> filter

`  before_action :authenticate_user!, except: [:index]` 



# 10. 방만들기

- 유저가 방을 만든다 .

*room_controller.rb*

```ruby
 def create
   @room = Room.new(room_params)
   @room.master_id = current_user.email
   
   respond_to do |format|
      if @room.save
       @room.user_admit_room(current_user) #room.rb
       p "create의 user_admit_room 실행"
       format.html { redirect_to @room, notice: 'Room was successfully created.' }
       format.json { render :show, status: :created, location: @room }
      else
       format.html { render :new }
       format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end
```

- 방을 만든 유저가 master_id가 된다.

  `@room.master_id = current_user.email`

- 방이 저장이 되면, 유저가 그 방에 admission되어야한다.

  `@room.user_admit_room(current_user)`

- admission관계를 설정하는 메소드를 설정한다.

- *room.rb*

  ```ruby
  def user_admit_room(user)
     # ChatRoom이 하나 만들어 지고 나면 다음 메소드를 같이 실행한다.
     # ChatRoom controller create에서 실행.
      Admission.create(user_id: user.id, room_id: self.id)
   end
   
  ```

- 방이 만들어질때 , trigger를 발동시킨다. 

- *room.rb*

  ```ruby
  after_commit :create_room_notification, on: :create
  
  def create_room_notification
      # 방만들었을때 index에서 방리스트에 append 해주는 트리거
      Pusher.trigger('room','create',self.as_json)
   end
  ```

- admission이 만들어질때 trigger를 발동시킨다

- *admission.rb*

  ```ruby
   after_commit :user_join_room_notification, on: :create
   after_commit :user_exit_room_notification, on: :destroy 
   
   
   def user_join_room_notification
       max_count = Room.where(id: self.room_id)[0].max_count
       admissions_count = Room.where(id: self.room_id)[0].admissions_count
     # 방에 들어갔을때 발생하는 트리거
     Pusher.trigger('room', 'join', self.as_json.merge({email: self.user.email, max_count: max_count,admissions_count: admissions_count }))
     Pusher.trigger("room_#{self.room_id}",'join', self.as_json.merge({email: self.user.email}))
   end
   
  ```

- 뷰에서 Pusher의 트리거 이벤트를 뷰에서 subscribe 한다.

- *index.html.erb*

  ```ruby
  		
  <script>
  	function room_created(data){
  		$('.room_list').prepend(`	
  		<div class="style3" style= "font-family:Do Hyeon">
  					<div= "row">
  						<div class="col-sx-12">
  							<div class="imagebox style2">
  								<div class="container ">
  									<div class ="row">
  									  <div class="check${data.id}"
  										<div>
  											<a href ="/rooms/${data.id}" ><font size="5">${data.room_title}</font></a>
  											<span style="float:right;font-family:Do Hyeon"><font size="5"><span class="current${data.id}">${data.admissions_count}</span> / ${data.max_count}</font></span>
  										</div>
  										
  										<div style ="font-family:Do Hyeon">
  											<span style="color:black" class ="col"><font style="font-family:Do Hyeon" size="4">${data.start_time_hour} : ${data.start_time_min} 에 보자!</font></span>
  											<div style="float:right;"><span><font size="5">${data.food_type}</font></span></div>
  										</div>
  									
  										 <!--<div class="Hashtag" style="font-family:Nanum Gothic Coding">
  										 	<span>
  										 	<%# @room.tags.each do |tag| %>
  										 		<%#= link_to "##{tag.name}", "/rooms/hashtags/#{tag.name}" %>
  										 	<%# end %></span>
  										 </div>-->
  										 
  									</div><!-- /.box-content -->
  								</div><!-- /.box-imagebox -->
  							</div><!-- /.imagebox style2 -->
  						</div><!-- /.col-sm-12 -->
  					</div>
  			</div>
  		`);
  	}
  	function user_joined(data){
  		var current = $(`.current${data.room_id}`);
  		current.text(parseInt(current.text())+1);
  	}
  
  	var pusher = new Pusher('<%= ENV["Pusher_key"] %>', {
  	   cluster: "<%= ENV["Pusher_cluster"] %>",
  	   encrypted: true
  	 });
  
  	var channel = pusher.subscribe('room');
  	
  	 channel.bind('create', function(data){
  		console.log("방만들어짐");
  		console.log(data);
  		room_created(data);
   	 });
  	
  	 channel.bind('join', function(data) {
  	   console.log("유저가 들어감");
  	   console.log(data);
  
  	 });
  </script>
  ```

- *show.html.erb*

  ```ruby
   function user_join(data) {
     		$('.room_user_list').prepend(`
      	 <tr class="user-${data.user_id}">
        		 <td colspan="8" style="padding-right: 10px;">${data.email}</td>
        		 <td colspan="8"><span class="current${data.room_id}">${ data.ready_state}</span></td>
       	 </tr>`);
   		}
  var pusher = new Pusher("<%= ENV["Pusher_key"]%>", {
          cluster: "<%= ENV["Pusher_cluster"] %>",
          encrypted: true
        });
       
  var channel = pusher.subscribe("room_<%=@room.id%>");
       
        channel.bind('join',function(data){
          console.log("유저입장");
          console.log(data);
          user_join(data);
          
        })
  ```

  

# 11. 방지우기

- 유저가 방을 나갈때 admission도 사라진다.
- admission이 사라지는 method정의

*room.rb*

```ruby
  def user_exit_room(user)
   @thisR = Room.where(id: self.id)[0]
   if (@thisR.admissions.count == 1)
     Admission.where(user_id: user.id, room_id: self.id)[0].destroy
     p "방 폭파조건"
     Room.where(id: self.id)[0].destroy
   else #방장여부 판별
     if (@thisR.master_id == user.email)
       p "if 문 들어옴"
       p @someone = User.find(@thisR.admissions.sample.user_id).email
       @thisR.update(master_id: @someone)
     end
     p @thisR.admissions.count
     p "방 사람들 수"
     p @thisR.master_id
     Admission.where(user_id: user.id, room_id: self.id)[0].destroy
   end
 end
```

> - 방장이 나갔다면, 방에있는 다른사람에게 방장을 임명해준다.
> - 그 채팅방의 인원이 0명인지 확인한다 => 방안에 인원이 0명인 방은 지운다.



*room_controller.rb*

```ruby
 def user_exit_room
    p "유저나가기 컨트롤러까지는 옴"
    @room.user_exit_room(current_user)
    # @room.zero_room_delete(current_user)
    if @room.room_state 
      @room.update(room_state: false)
    end
  end
```

- admission이 없어질때마다 감지하는 trigger를 놓는다.

*admission.rb*

```ruby
    after_commit :user_exit_room_notification, on: :destroy    

 def user_exit_room_notification
   Pusher.trigger("room",'exit',self.as_json)
   Pusher.trigger("room_#{self.room_id}",'exit',self.as_json)
 end
```

- 뷰에서 trigger 이벤트 subscribe
- 

*index.html.erb*

```ruby
	function user_exit(data){
		var current = $(`.current${data.room_id}`);
	    current.text(parseInt(current.text())-1);
	    console.log(current)
	}

	 channel.bind('exit',function(data){
	   user_exit(data)
	 });
```



*show.html.erb*

```ruby
$(document).on('ready', function(){
         
      function user_exit(data){
         $(`.user-${data.user_id}`).remove();
       }     


var channel = pusher.subscribe("room_<%=@room.id%>");
     
       channel.bind('exit',function(data){
       console.log("유저퇴장");
         user_exit(data);
      });
```



*show.html.erb* 에서 동작되는 exit 링크

```ruby
<%= link_to 'Exit',exit_room_path(@chat_room), method: 'delete', remote: true, data: {confirm: "이 방을 나가시겠습니까?"} %>
```



*routes.rb*

```ruby
  resources :rooms do 
    member do
     delete '/exit' => 'rooms#user_exit_room'
   end
 end
```



*user_exit_room.js* 가 실행된다. 

```ruby
alert("방을 나가셨습니다.");

location.href='/rooms'
```

> remote: true 조건때문에



# 12. 방에 참여하는 로직

*user.rb*

```ruby
 def joined_room?(room)
 # 유저가 그 방에 들어있는지 볼라구
 self.rooms.include?(room)
 end
```



*room_controller.rb*

```ruby
 def show

 respond_to do |format|
   if @room.chat_started?
    format.html { render 'chat' }
   else
     if @room.max_count > @room.admissions_count
       @room.user_admit_room(current_user) unless current_user.joined_room?(@room)  
       format.html { render 'show' }
     else
       if @room.admissions.exists?(user_id: current_user.id)
         format.html { render 'show' }
       else
         format.html {render 'alert'}
       end  
     end      
   end
 end
```



*alert.html.erb*

```ruby
<script>
 alert('이미 인원이 다 찬 방입니다.');
  location.href = "https://muckbo-devise-chat-binn02.c9users.io/";
</script>
```



*admission.rb*

```ruby
 after_commit :user_join_room_notification, on: :create

 def user_join_room_notification
     max_count = Room.where(id: self.room_id)[0].max_count
     admissions_count = Room.where(id: self.room_id)[0].admissions_count
   # 방에 들어갔을때 발생하는 트리거
   Pusher.trigger('room', 'join', self.as_json.merge({email: self.user.email, max_count: max_count,admissions_count:  }))
   Pusher.trigger("room_#{self.room_id}",'join', self.as_json.merge({email: self.user.email}))
 end
```



*index.html.erb*

```ruby
...	
	function user_joined(data){
		var current = $(`.current${data.room_id}`);
		current.text(parseInt(current.text())+1);
	}
...

channel.bind('join', function(data) {
	   console.log("유저가 들어감");
	   console.log(data);

	 });
...
```



show.html.erb

```ruby
... 
  function user_join(data) {
   		$('.room_user_list').prepend(`
    	 <tr class="user-${data.user_id}">
      		 <td colspan="8" style="padding-right: 10px;">${data.email}</td>
      		 <td colspan="8"><span class="current${data.room_id}">${ data.ready_state}</span></td>
     	 </tr>`);
 		}
...

channel.bind('join',function(data){
        console.log("유저입장");
        console.log(data);
        user_join(data);
        
      })
...   
```



# 13. 유저 레디

- 메소드를 정의한다

*user.rb*

```ruby
  def is_ready?(room)
    self.admissions.where(chat_room_id: room.id).first.ready_state
  end
```

*admission.rb*

```ruby
 def user_ready(user)
   Admission.where(user_id: user.id, room_id: self.id).update(ready_state: true)
 end
```



- 컨트롤러에서 수행한다

*room_controller.rb*

```ruby
def is_user_ready
   if current_user.is_ready?(@room) # 현재 레디상태라면
     render js: "console.log('이미 레디상태'); location.reload();"
   else  # 현재 레디상태가 아니라면
     @room.user_ready(current_user) # 현재유저의 레디상태 바꿔주기
     render js: "console.log('레디상태로 바뀌었습니다.'); location.reload();"
     # 현재 레디한 방 외에 모든방의 레디해제
     current_user.admissions.where.not(room_id: @room.id).destroy_all
      Room.where(admissions_count: 0).destroy_all
     # if
   end
 end
```



- 모델에서 트리거를 발동시킨다

admission.rb

```ruby
 after_commit :user_ready_check, on: :update


 def user_ready_check
   p "ready check"
   # p max_count = Room.where(id: self.room_id)[0].max_count
   max_count = Room.where(id: self.room_id)[0].max_count
   # ready_count = self.room.admissions.where(ready_state: true).size
   ready_count = Admission.where(room_id: self.room_id, ready_state: true).size
   
   Pusher.trigger("room_#{self.room_id}",'ready',self.as_json.merge({email: self.user.email, ready_count: ready_count, max_count: max_count}))
   if max_count == ready_count
     p "max_count == ready_count 코드  실행되고있당. "
     Pusher.trigger("room_#{self.room_id}",'start',self.as_json.merge({email: self.user.email, ready_count: ready_count, max_count: max_count}))
   end
 end 
```

>  ready를 max_count의 인원만큼 하면 start 트리거 실행



- 뷰에서 처리한다.

*show*

- ```ruby
  <script>
    $(document).on('ready', function(){
  	...
        function user_ready(data){
            console.log("user_ready func 들어옴")
          $(`.current${data.room_id}`).remove();
          $(`.current${data.room_id}`).append(`${data.ready_state}`);
          location.reload();
        }
        function user_ready(data){
            console.log("user_ready func 들어옴")
          $(`.current${data.room_id}`).remove();
          $(`.current${data.room_id}`).append(`${data.ready_state}`);
          location.reload();
        }
  	...
       
        var pusher = new Pusher("<%= ENV["Pusher_key"]%>", {
          cluster: "<%= ENV["Pusher_cluster"] %>",
          encrypted: true
        });
       
        var channel = pusher.subscribe("room_<%=@room.id%>");  
  	...   
        channel.bind('ready',function(data){
          console.log("레디발싸");
          user_ready(data);
        }) 
       channel.bind('start',function(data){
         console.log("start_chat 찍혔다.");
         start_chat(data);
       })
   });
  </script>
  ```

  start 트리거 작동시 start 버튼이 나온다.

  

*show.html.erb*

`<%= link_to 'ready', ready_chat_room_path(@chat_room), method: 'post',remote: true %>`

- 라우팅 

```ruby
  resources :rooms do 
    member do
     post '/ready' => 'rooms#is_user_ready'
   end
 end
```



# 14. 채팅시작 <- start버튼을 눌렀을때

- ready한 유저의 수와 방의 max_count가 같으면, 방장에게 start 버튼이 보인다.

*show.html.erb*

```ruvy
<div class="chat_link">
<% if @room.admissions.where(ready_state: true).size == @room.max_count %>
	<% if @room.master_id.eql?(current_user.email) %>
		<%= link_to 'Start', open_chat_room_path(@room), method: 'post', remote: true %>
	 <% end %>        
<% end %>
</div>
```



- 라우트 지정

*routes.rb*

```ruby
  resources :rooms do 
    member do
     post '/open_chat' => 'rooms#open_chat'
   end
  end
```



- 컨트롤러에서 액션지정

*room_controller.rb*

```ruby
 def open_chat
   p "오픈챗 됬다."
   @room.update(room_state: true)
   Pusher.trigger("room_#{@room.id}", 'chat_start', {})
 end
```

> trigger 작동.

- 뷰페이지의 트리거 작동

  

*show.html.erb*

```ruby
     channel.bind('chat_start', function(data) {
        location.reload();
     })
```



*room_controller.rb*

```ruby
 def show
    respond_to do |format|
      if @room.chat_started?
       format.html { render 'chat' }
      else
        if @room.max_count > @room.admissions_count
          @room.user_admit_room(current_user) unless current_user.joined_room?(@room)  
          format.html { render 'show' }
        else
          if @room.admissions.exists?(user_id: current_user.id)
            format.html { render 'show' }
          else
            format.html {render 'alert'}
          end  
        end      
      end
    end
  end
```

> 에 의해 chat으로 render가 된다.

- 트리거 설정



*chat.rb*

```ruby
after_commit :chat_message_notification, on: :create
 
 def chat_message_notification
   Pusher.trigger("room_#{self.room_id}", "chat", self.as_json.merge({email: self.user.email}))
 end
```



- 뷰페이지 실행

*view.html.erb*

```ruby
<div class="chat_list">
  <% @room.chats.each do |chat| %>
      <p><%= chat.user.email%> : <%= chat.message %><small> <%= chat.created_at %></small></p>
  <%end%>
</div>
<%= form_tag("/rooms/#{@room.id}/chat") do %>
  <%= text_field_tag :message %>
<% end %>

<%= link_to 'Back', rooms_path(@room) %>


<script>
  $('#message').val('');
 
 
  function user_chat(data){
      //  $('.chat_list').append(`<p>${data.email}님 께서 입장하셨습니다.</p>`);
      $('.chat_list').append(`<p>${data.email}: ${data.message} <small>(${data.created_at})</small></p>`)
  }
 
   var pusher = new Pusher("<%= ENV["Pusher_key"]%>", {
    cluster: "<%= ENV["Pusher_cluster"] %>",
    encrypted: true
  });
 
  var channel = pusher.subscribe("room_<%=@room.id%>");
 
  channel.bind('chat', function(data){
       user_chat(data);
       console.log("채팅중입니다.")
  });
</script>
```



# 15. pagination

1. gem 설치 <- kaminari 보고 순서대로 하기

   - kaminari
   - bootstarp-kaminari-views 

2. 모델에서 paginates 수 지정

   `    paginates_per 3`

3. 컨트롤러

   ```ruby
     def index
       @rooms = Room.page params[:page]
       @rooms.where(admissions_count: 0).destroy_all
     end
   ```

4. 뷰에 추가

   - *index.html.erb*

     <div class="text-center">				
     		<%= paginate @rooms, theme: 'twitter-bootstrap-4' %>
     		</div>

     

# 16. 로그용 database만들기

1. 챗방이 만들어 진뒤, 받을 parameter를 정한다.

   - 로그용 모델만들기

     `$ rails g model user_chat_log `

   - col 추가

     ```ruby
           t.string :room_title
           t.int :room_id
           t.int :user_id
           t.string :nickname
           t.date :chat_date
     
           t.timestamps
     ```

2. 로직추가

```ruby
    def open_chat
      p "오픈챗 됬다."
      @room.update(room_state: true)
      @room.admissions.each do |admission|
         UserChatLog.create(room_title: @room.room_title, room_id: @room.id, user_id: admission.user_id, nickname: admission.user.nickname, chat_date: admission.updated_at.to_date )
      end
      p "admission의 힘"
      Pusher.trigger("room_#{@room.id}", 'chat_start', {})
    end
```



# 17. 신고로직만들기

1. 신고 데베 만들기

   - *create_reports.rb*

     ```ruby
         create_table :reports do |t|
           
           t.string :user_email
           t.integer :user_id
           
           t.integer :report_reason
           t.text :report_description
           
           t.timestamps
     ```

2. 컨트롤러 로직

   - *room_controller.rb*

     ```ruby
      def report
        @report = Report.new
      end
      
      def report_create
        p "신고받음"
             @report = Report.create(report_reason: params[:report_reason], report_description: params[:report_description])
             @report.user_id = current_user.id
             @report.user_email = current_user.email
            
      end
     ```

3. 뷰페이지 만들기

   - *report.html.erb*

     ```ruby
     <section class="style3 flat-row">
     			<div class="container">
     				<div class="row">
     					<div class="col-md-12">	
     					<body class="bg-light">
     		
     				    	<div class="cover-container d-flex w-100 h-100 p-3 mx-auto flex-column">
     						<div class="filter-result style2" style="font-family:Nanum Gothic Coding">
     						<main role="main" class="inner cover">
                                 <h1 class="cover-heading">신고하기</h1>
                                 <br/>
                                 <p class="lead">장난 혹은 허위사실로 신고시에는 이용정지를 당하실수있습니다.</p>
                              </main>
     						
     					    
     						<div class="one-half">
     							<div class="wrap-listing report">
     							        <label>신고사유 선택</label>
     										<span class="ti-angle-down"></span>
     										<select name="report_reason">
     											<option value="1">약속장소에 나오지 않음</option>
     											<option value="2">돈을 내지 않았음</option>
     											<option value="3">기타사유</option>
     										</select>
     										<br/>
     										<p>만약,기타사유를 고르셨다면, 신고사유 설명란에 이유를 함께 기재하여 주십시오.</p>
     										
     								    <label>신고사유 설명</label>
     									   <input type="text" name="report_description" placeholder="정확한 일자와 이유 등 최대한 상세하게 상황을 기술해주십시오">
     							    	</div><!-- /.wrap-listing -->
         							<div class="btn-more match">
     								    <%= link_to '신고하기', report_path(@report), method: 'post', remote: true %>
     							    </div>
     							</div>
     						</div><!-- /.filter-result -->
     						</div>
     					</body>
     					</div><!-- /.col-md-12 -->
     			</div><!-- /.row -->
     		</div>
     </section>
     ```

   - *report_create.js.erb*

     ```ruby
     alert('신고가 완료되었습니다.');
     document.location.href="/";
     ```

     
