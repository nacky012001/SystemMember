class MembersController < ApplicationController
  def index

  end

  def list
    members = Member.offset(params[:start]).limit(params[:length]).all
    count = Member.count

    res = {draw: params[:draw], recordsTotal: count, recordsFiltered: count, data: members.map { |m| m.attributes.symbolize_keys.except(:id, :created_at, :updated_at).values }}

    respond_to do |format|
      format.json { render json: res.to_json }
    end
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
    begin
      @records = MemberSystem::MemberFilesParser.parse(params[:member_files])
      
      @records.each { |r| Member.create(r) }
      
      flash[:message] = [:import_member_records_success, {:val => @records.length}]
    rescue
      flash[:error] = :import_member_records_failed
    end

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
