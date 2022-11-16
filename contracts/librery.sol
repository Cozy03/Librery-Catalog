// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract librery {
    event NewBookAdded(address owner, uint bookId);
    event BookState(uint bookId, bool state);

    constructor() {}

    struct Book {
        uint id;
        string name;
        string author;
        uint year;
        bool readOrNot;
    }

    Book[] private registeredBooks;

    mapping(uint => address) booksOwned;

    uint idbook = 0;

    function bookIntake(
        string memory _name,
        string memory _auther,
        uint _year,
        bool _ifRead
    ) external {
        registeredBooks.push(Book(idbook, _name, _auther, _year, _ifRead));
        booksOwned[idbook] = msg.sender;
        emit NewBookAdded(msg.sender, idbook);
        idbook++;
    }

    function getBooks(bool state) private view returns (Book[] memory) {
        Book[] memory temp = new Book[](registeredBooks.length);

        uint track;

        for (uint i = 0; i < registeredBooks.length; i++) {
            if (
                booksOwned[i] == msg.sender &&
                registeredBooks[i].readOrNot == state
            ) {
                temp[track] = registeredBooks[i];
                track++;
            }
        }
        Book[] memory ans = new Book[](track);

        for (uint i = 0; i < track; i++) {
            ans[i] = temp[i];
        }
        return ans;
    }

    function getReadBooks() external view returns (Book[] memory) {
        return getBooks(true);
    }

    function getUnReadBooks() external view returns (Book[] memory) {
        return getBooks(false);
    }

    function markRead(uint b_id) external {
        require(
            msg.sender == booksOwned[b_id],
            "Only the owner can read the book and use this function!"
        );
        require(
            registeredBooks[b_id].readOrNot == false,
            "The book is already read."
        );
        registeredBooks[b_id].readOrNot = true;
        emit BookState(b_id,true);
    }

    function markUnRead(uint b_id) external {
        require(
            msg.sender == booksOwned[b_id],
            "Only the owner can read the book and use this function!"
        );
        require(
            registeredBooks[b_id].readOrNot == true,
            "The book is not read yet."
        );
        registeredBooks[b_id].readOrNot = false;
            emit BookState(b_id,false);

    }

    function deleteBook(uint b_id) external {
        require(
            msg.sender == booksOwned[b_id],
            "Only the owner can delete ther book!"
        );
        remove_i_book(b_id);
    }

    function remove_i_book(uint i) public {
        uint k = 0;
        uint p = registeredBooks.length;
        for (k = i + 1; k < p; k++) {
            registeredBooks[k - 1] = registeredBooks[k];
        }
        registeredBooks.pop();
    }
}
