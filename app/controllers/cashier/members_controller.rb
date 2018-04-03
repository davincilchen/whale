class Cashier::MembersController < Cashier::BaseController
  before_action :authenticate_user!

  def index
    @members = Member.all.order(created_at: :desc)

    respond_to do |format|
      format.html
      format.csv { send_data(@members.to_csv) }
    end
  end

  def show
    @member = Member.find(params[:id])  
  end
  
  def show_orders
    @member = Member.find(params[:id])
    @orders =@member.orders
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(member_params)
    if @member.save!
      flash[:notice] = "成功新增會員"
      redirect_to cashier_member_path(@member)
    else
      flash[:alert] = @member.errors.full_messages.to_sentence
      render :new
    end
  end
  
  def create_successfully
    @member = Member.find(params[:id])
  end

  def search
    
  end
  
  def birthday_this_month
    temp = Member.all
    @members = temp.group_by{ |t| t.birthday.month == DateTime.now.month }
  end
  
  def birthday_next_month
    temp = Member.all    
    @members = temp.group_by{ |t| t.birthday.month == DateTime.now.month + 1 }
  end

 
  def search_outcome
    puts params[:phone]
    
    key_word = ''
    if params[:phone] != nil
      key_word = params[:phone]
      @members = Member.where("phone like ? OR email LIKE ?", "%"+key_word+"%", "%"+key_word+"%")      
#    elsif params[:email] != nil
#      key_word = params[:email]
#      @members = Member.where("email like ?", "%"+key_word+"%")
#      puts @members
#    else
      
    end
    render :json => @members
    
  end

  

  private

  def member_params
    params.require(:member).permit(
      :name,
      :gender,
      :birthday,
      :phone,
      :fax,
      :member_code,
      :email,
      :skin_type_id,
      :hair_code,
      :avatar,
      :remark
      )
  end
end
