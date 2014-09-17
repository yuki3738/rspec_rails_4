require'spec_helper'

describe Contact do
  # 姓と名とメールがあれば有効な状態であること
  it "is valid with a firstname, lastname and email" do
    contact = Contact.new(
      firstname: 'Aaron',
      lastname: 'Sumber',
      email: 'tester@example.com')
      expect(contact).to be_valid
    end

  # 名がなければ無効な状態であること
  it "is invalid without a firstname" do
    expect(Contact.new(firstname: nil)).to have(1).errors_on(:firstname)
  end
  # 姓がなければ無効な状態であること
  it "is invalid without a lastname" do
    expect(Contact.new(lastname: nil)).to have(1).errors_on(:lastname)
  end


  # メールアドレスがなければ無効な状態であること
  it "is invalid without an email address" do
    Contact.create(
      firstname: 'Joe', lastname: 'Tester',
        email: 'tester'
    )
  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address"　do
    Contact.create(
      firstname: 'Joe', lastname: 'Tester',
        email: 'tester@example.com')
    contact = Contact.new(
      firstname: 'Jane', lastname: 'Tester',
        email: 'tester@example.com')
    expect(contact).to have(1).errors_on(:email)
  end
  # 連絡先のフルネームを文字列として返すこと
  it "returns a contact's full name as a string"
end
