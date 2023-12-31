package com.fastcampus.ch4.domain;

import java.util.Date;
import java.util.Objects;

public class BoardDto {
    private Integer bno;
    private String title;
    private String content;
    private String writer;

    private String Country;

    private int view_cnt;
    private int comment_cnt;
    private Date reg_date;
    public BoardDto(){};
    public BoardDto(String title, String content, String writer, String Country) {
        this.title = title;
        this.content = content;
        this.writer = writer;
        this.Country = Country;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        BoardDto boardDto = (BoardDto) o;
        return Objects.equals(bno, boardDto.bno) && Objects.equals(title, boardDto.title) && Objects.equals(content, boardDto.content) && Objects.equals(writer, boardDto.writer)&& Objects.equals(Country, boardDto.Country);
    }

    @Override
    public int hashCode() {
        return Objects.hash(bno, title, content, writer, Country);
    }

    @Override
    public String toString() {
        return "BoardDto{" +
                "bno=" + bno +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", writer='" + writer + '\'' +
                ", Country='" + Country + '\'' +
                ", view_cnt=" + view_cnt +
                '}';
    }

    public Integer getBno() {
        return bno;
    }

    public void setBno(Integer bno) {
        this.bno = bno;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCountry() {
        return Country;
    }

    public void setCountry(String Country) {
        this.Country = Country;
    }

    public String getContent() {
        return content;
    }


    public void setContent(String content) {
        this.content = content;
    }

    public String getWriter() {
        return writer;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }

    public int getView_cnt() {
        return view_cnt;
    }

    public void setView_cnt(int view_cnt) {
        this.view_cnt = view_cnt;
    }

//    public int getComment_cnt() {
//        return comment_cnt;
//    }
//
//    public void setComment_cnt(int comment_cnt) {
//        this.comment_cnt = comment_cnt;
//    }

    public Date getReg_date() {
        return reg_date;
    }

    public void setReg_date(Date reg_date) {
        this.reg_date = reg_date;
    }
}
