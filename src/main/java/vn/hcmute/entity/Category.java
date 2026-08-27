package vn.hcmute.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "Category")
@NamedQuery(name = "Category.findAll", query = "SELECT c FROM Category c")
public class Category implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cate_id")
    private int categoryId;

    @Column(name = "cate_name", columnDefinition = "NVARCHAR(255)", nullable = false)
    private String categoryname;

    @Column(name = "icons", columnDefinition = "NVARCHAR(255)")
    private String images;

    @Column(name = "status", nullable = true)
    private Integer status = 1;

    @OneToMany(mappedBy = "category", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Video> videos = new ArrayList<>();

    public Category() {
        super();
    }

    public Category(int categoryId, String categoryname, String images, Integer status) {
        super();
        this.categoryId = categoryId;
        this.categoryname = categoryname;
        this.images = images;
        this.status = (status != null) ? status : 1;
    }

    public Category(String categoryname, String images, Integer status) {
        super();
        this.categoryname = categoryname;
        this.images = images;
        this.status = (status != null) ? status : 1;
    }

    public Category(String categoryname, String images) {
        super();
        this.categoryname = categoryname;
        this.images = images;
        this.status = 1;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryname() {
        return categoryname;
    }

    public void setCategoryname(String categoryname) {
        this.categoryname = categoryname;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public int getStatus() {
        return (status != null) ? status : 1;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public List<Video> getVideos() {
        return videos;
    }

    public void setVideos(List<Video> videos) {
        this.videos = videos;
    }

    public Video addVideo(Video video) {
        getVideos().add(video);
        video.setCategory(this);
        return video;
    }

    public Video removeVideo(Video video) {
        getVideos().remove(video);
        video.setCategory(null);
        return video;
    }

    // ==========================================
    // CÁC HÀM ALIAS GETTER/SETTER TƯƠNG THÍCH JSP EL
    // ==========================================
    public int getId() {
        return categoryId;
    }

    public void setId(int id) {
        this.categoryId = id;
    }

    public int getCategoryid() {
        return categoryId;
    }

    public void setCategoryid(int categoryid) {
        this.categoryId = categoryid;
    }

    public String getName() {
        return categoryname;
    }

    public void setName(String name) {
        this.categoryname = name;
    }

    public String getCategoryName() {
        return categoryname;
    }

    public void setCategoryName(String categoryName) {
        this.categoryname = categoryName;
    }

    public String getIcon() {
        return images;
    }

    public void setIcon(String icon) {
        this.images = icon;
    }

    public String getIcons() {
        return images;
    }

    public void setIcons(String icons) {
        this.images = icons;
    }

    @Override
    public String toString() {
        return "Category [categoryId=" + categoryId + ", categoryname=" + categoryname + ", images=" + images
                + ", status=" + status + "]";
    }
}
