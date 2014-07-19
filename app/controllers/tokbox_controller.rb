require'opentok'

class TokboxController < ApplicationController
  def mentor_room
    @tok_session_id = params[:session] if params[:session]
    @tok_token = params[:token] if params[:token]
    @course_id = params[:course_id]
    @course_topic_id = params[:course_topic_id]
    @course_topic_duration=params[:duration] if params[:duration]
    @course_name=params[:course].gsub(/-/," ") if params[:course]
    @user_display_name=params[:user].gsub(/-/," ") if params[:user]
    @user_account_id = params[:user_account_id] 
    @course_topic_course_content=params[:course_topic].gsub(/-/," ") if params[:course_topic]
  end

  def student_room
    @tok_session_id = params[:session]
    @tok_token = params[:token]
    @course_id = params[:course_id]
    @course_topic_id = params[:course_topic_id]
    @course_topic_duration = params[:duration] if params[:duration]
    @course_name = params[:course].gsub(/-/," ") if params[:course]
    @user_display_name = params[:user].gsub(/-/," ") if params[:user]
    @user_account_id = params[:user_account_id] 
    @course_topic_course_content = params[:course_topic].gsub(/-/," ") if params[:course_topic]
  end
  
  def screen_share
    header={"accountid" => SCREEN_ACCOUNTID,"authtoken" => SCREEN_AUTHTOKEN}
    response=Typhoeus::Request.post("https://api.screenleap.com/v1/screen-shares", headers: header)
    @json=JSON.parse(response.body)
    @applet_html=@json['appletHtml']
    @view_url=@json['viewerUrl']
    render :partial=>"screen_share",:layout =>false
    #render :js =>"$('#screen').html('Screen share is loading......');"
  end

  def data_from_edupdu
    #    header = {"email" => 'shareef.gkce@gmail.com',"password" =>'shareef'}
    response = Typhoeus::Request.new("http://www.edupdu.com/sessions",method: :post)
    @json = response
  end
  
  def send_live_session_status
    @course = params[:course]
    @course_topic = params[:course_topic]
    @status = params[:session_status]
    @user_account = params[:user_account_id]
    respond_to do |format|
      format.js
    end
  end
  
  def send_student_live_status
    redirect_to "http://edupdu.com/#{params[:param1]}/courses/#{params[:param]}/student_course_display"
  end
  

end
