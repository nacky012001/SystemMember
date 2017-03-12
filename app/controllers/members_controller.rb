class MembersController < ApplicationController
  def index
  end

  def new
    @member = Member.new
  end

  def show
    @member = Member.find(params[:id])
  end

  def create
    permitted_params = params.require(:member).permit(:name, :email, :gender, :age)

    @member = Member.create(permitted_params)

    redirect_to member_path(@member)
  end

  def upload

    redirect_to members_path
  end

  def preview
    begin
      @records = MemberSystem::MemberFilesParser.parse(params[:member_files])
    rescue MemberSystem::ExceedMaximumRows
      flash[:error] = :exceed_maximum_rows
      redirect_to import_members_path
    rescue
      flash[:error] = :parsing_excel_failed 
      redirect_to import_members_path
    end
  end
end
