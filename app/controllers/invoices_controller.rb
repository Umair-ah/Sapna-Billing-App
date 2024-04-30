class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[ show edit update destroy ]
  before_action :authenticate_admin!

  def index
    if params[:search].present?
      @invoices_pagy, @invoices = pagy(Invoice.where(number: params[:search]))
      flash[:notice]="Record Found!"
    else
      @invoices_pagy, @invoices = pagy(Invoice.order(updated_at: :desc))
    end
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: [@invoice.number, @invoice.date].join('-'),
               template: "invoices/invoice",
               formats: [:html],
               disposition: :inline,
               layout: 'pdf'
      end
    end
  end

  def new
    @invoice = Invoice.new
    @invoice.items.build
  end

  def edit
  end

  def create
    @invoice = Invoice.new(invoice_params)

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to invoice_url(@invoice), notice: "Invoice was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to invoice_url(@invoice), notice: "Invoice was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @invoice.destroy

    respond_to do |format|
      format.html { redirect_to invoices_url, notice: "Invoice was successfully destroyed." }
    end
  end

  private
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    def invoice_params
      params.require(:invoice).permit(:number, :date, :to, :total_amount, items_attributes: [:id, :description, :rate, :quantity, :amount,:_destroy])
    end
end
