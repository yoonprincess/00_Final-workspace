package com.mig.blb.member.model.vo;

import java.sql.Date;

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
public class Point {
	
	private int pointNo;//	POINT_NO	NUMBER
	private int pointAmt;//	POINT_AMT	NUMBER
	private String pointReason;//	POINT_REASON	VARCHAR2(225 BYTE)
	private Date pointDate;//	POINT_DATE	DATE
	private String memberId;//	MEMBER_ID	VARCHAR2(20 BYTE)
}
