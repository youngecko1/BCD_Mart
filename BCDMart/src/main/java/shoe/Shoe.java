package shoe;

public class Shoe {
	private String upload_id;
	private String brand;
	private String shoe_name;
	private String color;
	private int quantity;
	private int sizes;
	private int price;
	private String type;
	private String pimg;
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getpimg() {
		return pimg;
	}
	public void setpimg(String pimg) {
		this.pimg = pimg;
	}
	public String getUpload_id() {
		return upload_id;
	}
	public void setUpload_id(String upload_id) {
		this.upload_id = upload_id;
	}

	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getShoe_name() {
		return shoe_name;
	}
	public void setShoe_name(String shoe_name) {
		this.shoe_name = shoe_name;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getSizes() {
		return sizes;
	}
	public void setSizes(int sizes) {
		this.sizes = sizes;
	}
}
