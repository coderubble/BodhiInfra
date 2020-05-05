CREATE TABLE users(
    email_id VARCHAR(20) PRIMARY KEY,
    password VARCHAR(120),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    user_type CHAR NOT NULL,
    dob DATE NOT NULL,
    address VARCHAR(300) NOT NULL,
    contact_no VARCHAR(20) NOT NULL
);

INSERT INTO
    public.users(
        email_id,
        password,
        first_name,
        last_name,
        user_type,
        dob,
        address,
        contact_no
    )
VALUES
    (
        'peter@bodhi.com',
        'peter',
        'Peter',
        'Vidal',
        'P',
        '1950-10-10',
        'dummy address',
        '+91123456789'
    );

INSERT INTO
    public.users(
        email_id,
        password,
        first_name,
        last_name,
        user_type,
        dob,
        address,
        contact_no
    )
VALUES
    (
        'clark@bodhi.com',
        'clark',
        'Clark',
        'Wille',
        'C',
        '1950-10-10',
        'dummy address',
        '+91123456789'
    );

INSERT INTO
    public.users(
        email_id,
        password,
        first_name,
        last_name,
        user_type,
        dob,
        address,
        contact_no
    )
VALUES
    (
        'shawn@bodhi.com',
        'shawn',
        'Shawn',
        'Wilson',
        'S',
        '1950-10-10',
        'dummy address',
        '+91123456789'
    );