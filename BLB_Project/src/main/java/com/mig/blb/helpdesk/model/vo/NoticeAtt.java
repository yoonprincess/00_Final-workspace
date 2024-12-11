package com.mig.blb.helpdesk.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class NoticeAtt {

	private int noticeAttNo;
	private String origFileName;
	private String saveFileName;
	private String savePath;
	private String noticeAttStatus;
	private int noticeNo;
}
